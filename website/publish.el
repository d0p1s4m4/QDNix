(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

(use-package templatel :ensure t)
(use-package htmlize
	:ensure t
	:config
	(setq org-html-htmlize-output-type 'css))
(use-package weblorg :ensure t)

(require 'weblorg)

;; ---------------------------------------------------------------------
;; global config (build dir, build env etc)
;; ---------------------------------------------------------------------

(if (string= (getenv "ENV") "prod")
	(setq weblorg-default-url "https://qdnix.d0p1.eu")
	(setq weblorg-default-url ""))

(setq qdnix--build-dir "generated")

;; ---------------------------------------------------------------------
;; Process Manual page
;; ---------------------------------------------------------------------

(setq qdnix--all-man (append
						 (directory-files-recursively "../src" "\\.[1-9]$")
						 (directory-files-recursively "../thirdparty" "\\.[1-9]$")))

(defun qdnix--parse-man (source)
	(let (html keywords fname)
		(setq html (shell-command-to-string (concat "mandoc -Thtml -O fragment,man='/man/%S/%N.html' " source)))
		(setq fname (file-name-nondirectory source))
		(weblorg--prepend keywords (cons "html" html))
		(weblorg--prepend keywords
			(cons "title" (upcase
							  (concat (file-name-sans-extension fname) "(" (file-name-extension fname) ")"))))
		(weblorg--prepend keywords (cons "cat" (file-name-extension fname)))
		(weblorg--prepend keywords (cons "file" fname))
		(weblorg--prepend keywords (cons "slug" (weblorg--slugify (file-name-sans-extension fname))))
		(weblorg--prepend keywords (cons "file_slug" (weblorg--slugify fname)))
		keywords))

(defun qdnix--man-brief (source)
	(let (keywords fname)
		(setq fname (file-name-nondirectory source))
		(weblorg--prepend keywords (cons "cat" (file-name-extension fname)))
		(weblorg--prepend keywords (cons "slug" (weblorg--slugify (file-name-sans-extension fname))))
		(weblorg--prepend keywords (cons "name" (file-name-sans-extension fname)))
		keywords))

;; -----------------------------------------------------------------------
;; Weblorg site and route
;; -----------------------------------------------------------------------
(weblorg-site
	:theme nil
	:template-vars '(
						("site_name" . "Quick'n'dirty *NIX")
						("site_owner" . "contact@qdnix.d0p1.eu")
						("site_description" . "Portable UNIX-like Operating System")))

(weblorg-route
	:name "news"
	:input-pattern "news/*.org"
	:template "news.html"
	:output (concat qdnix--build-dir "/news/{{ slug }}.html")
	:url "/news/{{ slug }}.html")

(weblorg-route
	:name "feed"
	:input-pattern "news/*.org"
	:input-aggregate #'weblorg-input-aggregate-all-desc
	:template "feed.xml"
	:output (concat qdnix--build-dir "/feed.xml")
	:url "/feed.xml")

(weblorg-route
	:name "pages"
	:input-pattern "pages/*.org"
	:template "page.html"
	:output (concat qdnix--build-dir "/{{ slug }}.html")
	:url "/{{ slug }}.html")

(weblorg-route
	:name "index"
	:input-pattern "news/*.org"
	:input-aggregate #'weblorg-input-aggregate-all-desc
	:template "index.html"
	:output (concat qdnix--build-dir "/index.html")
	:url "/")

(weblorg-route
	:name "man"
	:input-source (mapcar (lambda(p) `(("post" . ,(qdnix--parse-man p)))) qdnix--all-man)
	:template "man.html"
	:output (concat qdnix--build-dir "/man/{{ cat }}/{{ slug }}.html")
	:url "/man/{{ cat }}/{{ slug }}.html")

(weblorg-route
	:name "man-index"
	:input-source `((
						("title" . "Manual Page Index")
						("slug" . "man")
						("mans" . ,(mapcar (lambda(p) (qdnix--man-brief p)) qdnix--all-man))))
	:template "man-index.html"
	:output (concat qdnix--build-dir "/man/index.html")
	:url "/man")

(weblorg-route
	:name "doxygen"
	:url "/doxygen")

(weblorg-copy-static
	:output (concat qdnix--build-dir "/static/{{ file }}")
	:url "/static/{{ file }}")

(weblorg-export)
