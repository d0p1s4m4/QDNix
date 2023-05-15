.if !defined(_QDNIX_HOST_MK_)
_QDNIX_HOST_MK_=1

HOST_CXX ?= c++
HOST_CC	?= cc
HOST_CPP ?= cpp
HOST_LD ?= ld
HOST_AR ?= ar
HOST_RANLIB ?= ranlib

HOST_COMPILE.c ?= ${HOST_CC} -c
HOST_COMPILE.cc ?= ${HOST_CXX} -c


.endif
