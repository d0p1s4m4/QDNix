#!/usr/bin/env bash

hostname='https://qdnix.d0p1.eu'
rootdir="${1}"

echo '<?xml version="1.0" encoding="UTF-8"?>'
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'

recurse_readir() {
	dir="${1/%\//}"
	for m in "${dir}/"*; do
		if [ -d "${m}" ]; then
			if [[ "$m" != *"doxygen"* ]]; then
				recurse_readir "${m}"
			fi
		else
			lastmod=$(date -r "${m}" +"%Y-%m-%d")
			echo '<url>'
			echo "<loc>${m/$rootdir/$hostname}</loc>"
			echo "<lastmod>${lastmod}</lastmod>"
			echo '</url>'
		fi
	done
}

recurse_readir "${rootdir}"

echo '</urlset>'
