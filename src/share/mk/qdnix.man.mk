.include <qdnix.init.mk>

_MSECTIONS = 1 2 3 4 5 6 7 8 9
_MSECTIONREGEX = ${_MSECTIONS:ts|}
.SUFFIXES: ${_MSECTIONS:@N@.$N@}

PANDOC = pandoc
TEMPLATE = ${SRCDIR}/website/template/man.html
PANDOC_FLAGS = --from man --to html -s --template ${TEMPLATE}

MANINSTALL = install -o ${MANOWNER} -g ${MANGROUP} -m ${MANMODE}

MAN ?= ${MAN1} ${MAN2} ${MAN3} ${MAN4} ${MAN5} ${MAN6} ${MAN7} ${MAN8} ${MAN9}

.PHONY: maninstall htmlinstall htmlpages

maninstall:
.if defined(MAN1) && !empty(MAN1)
	${MANINSTALL} ${MAN1} ${DESTDIR}${MANDIR}1/
.endif
.if defined(MAN2) && !empty(MAN2)
	${MANINSTALL} ${MAN2} ${DESTDIR}${MANDIR}2/
.endif
.if defined(MAN3) && !empty(MAN3)
	${MANINSTALL} ${MAN3} ${DESTDIR}${MANDIR}3/
.endif
.if defined(MAN4) && !empty(MAN4)
	${MANINSTALL} ${MAN4} ${DESTDIR}${MANDIR}4/
.endif
.if defined(MAN5) && !empty(MAN5)
	${MANINSTALL} ${MAN5} ${DESTDIR}${MANDIR}5/
.endif
.if defined(MAN6) && !empty(MAN6)
	${MANINSTALL} ${MAN6} ${DESTDIR}${MANDIR}6/
.endif
.if defined(MAN7) && !empty(MAN7)
	${MANINSTALL} ${MAN7} ${DESTDIR}${MANDIR}7/
.endif
.if defined(MAN8) && !empty(MAN8)
	${MANINSTALL} ${MAN8} ${DESTDIR}${MANDIR}8/
.endif
.if defined(MAN9) && !empty(MAN9)
	${MANINSTALL} ${MAN9} ${DESTDIR}${MANDIR}9/
.endif

__installpage: .USE
.for S in ${_MSECTIONS}
	@mkdir -p ${DESTDIR}/html/man/man${S}
.endfor
	install ${.ALLSRC} ${.TARGET}

htmlinstall: htmlpages
htmlpages::

HTMLPAGES = ${MAN:C/\.(${_MSECTIONREGEX})\$/.html\1/}
.NOPATH: ${HTMLPAGES}
.SUFFIXES:	${_MSECTIONS:@N@.html$N@}

${_MSECTIONS:@N@.$N.html$N@}: 
	${PANDOC} ${PANDOC_FLAGS} --metadata category=${.IMPSRC:T:E} -o ${.TARGET} ${.IMPSRC}


.for F in ${HTMLPAGES:O:u}
_F:=		${DESTDIR}/html/man/${F:T:E:S/html/man/}/${F:R:S-/index$-/x&-}.html

${_F}:		${F} __installpage

htmlpages::	${_F}
.PRECIOUS:	${_F}
.endfor

### Clean
.undef _F
