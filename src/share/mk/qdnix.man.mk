.include <qdnix.init.mk>

PANDOC = pandoc
TEMPLATE = ${SRCDIR}/website/template/man.html
PANDOC_FLAGS = --from man  -s --template ${TEMPLATE}

MANINSTALL = install -o ${MANOWNER} -g ${MANGROUP} -m ${MANMODE}

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

htmlinstall:
.if defined(MAN1) && !empty(MAN1)
	mkdir -p ${DESTDIR}/html/man/man1
.for m in ${MAN1}
	${PANDOC} ${PANDOC_FLAGS} --metadata category=1 -o ${DESTDIR}/html/man/man1/${m:R:S/$/.html/g} ${m}
.endfor
.endif
.if defined(MAN2) && !empty(MAN2)
	mkdir -p ${DESTDIR}/html/man/man2
.for m in ${MAN2}
	${PANDOC} ${PANDOC_FLAGS} --metadata category=2 -o ${DESTDIR}/html/man/man2/${m:R:S/$/.html/g} ${m}
.endfor
.endif
.if defined(MAN3) && !empty(MAN3)
	mkdir -p ${DESTDIR}/html/man/man3
.for m in ${MAN3}
	${PANDOC} ${PANDOC_FLAGS} --metadata category=3 -o ${DESTDIR}/html/man/man3/${m:R:S/$/.html/g} ${m}
.endfor
.endif
.if defined(MAN4) && !empty(MAN4)
	mkdir -p ${DESTDIR}/html/man/man4
.for m in ${MAN4}
	${PANDOC} ${PANDOC_FLAGS} --metadata category=4 -o ${DESTDIR}/html/man/man4/${m:R:S/$/.html/g} ${m}
.endfor
.endif
.if defined(MAN5) && !empty(MAN5)
	mkdir -p ${DESTDIR}/html/man/man5
.for m in ${MAN5}
	${PANDOC} ${PANDOC_FLAGS} --metadata category=5 -o ${DESTDIR}/html/man/man5/${m:R:S/$/.html/g} ${m}
.endfor
.endif
.if defined(MAN6) && !empty(MAN6)
	mkdir -p ${DESTDIR}/html/man/man6
.for m in ${MAN6}
	${PANDOC} ${PANDOC_FLAGS} --metadata category=6 -o ${DESTDIR}/html/man/man6/${m:R:S/$/.html/g} ${m}
.endfor
.endif
.if defined(MAN7) && !empty(MAN7)
	mkdir -p ${DESTDIR}/html/man/man7
.for m in ${MAN7}
	${PANDOC} ${PANDOC_FLAGS} --metadata category=7 -o ${DESTDIR}/html/man/man7/${m:R:S/$/.html/g} ${m}
.endfor
.endif
.if defined(MAN8) && !empty(MAN8)
	mkdir -p ${DESTDIR}/html/man/man8
.for m in ${MAN8}
	${PANDOC} ${PANDOC_FLAGS} --metadata category=8 -o ${DESTDIR}/html/man/man8/${m:R:S/$/.html/g} ${m}
.endfor
.endif
.if defined(MAN9) && !empty(MAN9)
	mkdir -p ${DESTDIR}/html/man/man9
.for m in ${MAN9}
	${PANDOC} ${PANDOC_FLAGS} --metadata category=9 -o ${DESTDIR}/html/man/man9/${m:R:S/$/.html/g} ${m}
.endfor
.endif
