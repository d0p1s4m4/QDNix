.include <qdnix.init.mk>

##### Basic targets
includes: ${INCS} incinstall


##### Install rules
incinstall::	# ensure existence
.PHONY:		incinstall

__incinstall: .USE
	@${MSG.INSTALL}
	@${INSTALL_FILE} -m ${NONBINMODE} ${.ALLSRC} ${.TARGET}

.for F in ${INCS:O:u}
_FDIR:=		${INCSDIR_${F:C,/,_,g}:U${INCSDIR}}	# dir override
_FNAME:=	${INCSNAME_${F:C,/,_,g}:U${INCSNAME:U${F}}} # name override
_F:=		${DESTDIR}${_FDIR}/${_FNAME}		# installed path

${_F}:		${F} __incinstall			# install rule

incinstall::	${_F}
.PRECIOUS:	${_F}					# keep if install fails
.endfor

.undef _FDIR
.undef _FNAME
.undef _F
