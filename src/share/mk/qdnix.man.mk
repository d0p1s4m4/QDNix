.include <qdnix.init.mk>

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
	mkdir -p ${DESTDIR}/man1
