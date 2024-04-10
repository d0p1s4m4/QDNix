.include <qdnix.init.mk>

.if !defined(NOSUBDIR)

__recurse: .USE
	${MAKEDIRTARGET} ${.TARGET:C/^[^-]*-//} ${.TARGET:C/-.*$//}

.for targ in ${TARGETS}
.for dir in ${SUBDIR}
.if ${dir} == ".WAIT"
SUBDIR_${targ} += .WAIT
.elif !commands(${targ}-${dir})
${targ}-${dir}: .PHONY .MAKE __recurse
SUBDIR_${targ}+= ${targ}-${dir}
.endif
.endfor
subdir-${targ}: .PHONY ${SUBDIR_${targ}}
${targ}: subdir-${targ}
.endfor

.endif # !NOSUBDIR

${TARGETS}:
