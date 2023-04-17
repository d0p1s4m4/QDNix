.MAIN: all

_SUBDIRUSE: .USE
	@for entry in ${SUBDIR}; do \
		echo "===> $$entry"; \
		cd "${.CURDIR}/$${entry}"; \
		${MAKE} ${.TARGET:realinstall=install}; \
	done

${SUBDIR}::
	echo ${.MAKEFLAGS}
	cd ${.CURDIR}/${.TARGET}; ${.MAKE} all

.if !target(all)
all: _SUBDIRUSE
.endif

.if !target(clean)
clean: _SUBDIRUSE
.endif

.if !target(www)
www: _SUBDIRUSE
.endif

.if !target(distrib-dirs)
distrib-dirs: _SUBDIRUSE
.endif

.if !target(maninstall)
maninstall: _SUBDIRUSE
.endif

${TARGETS}:
