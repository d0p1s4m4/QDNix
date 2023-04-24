#!/bin/sh

set -e

PRGNAME=$(basename "$0")

BUILD_DIR="$(pwd)/build"
HOST_DIR="${BUILD_DIR}/host"
HOST_BIN_DIR="${HOST_DIR}/bin"
SRC_DIR="$(pwd)/src"
WEBSITE_DIR="${BUILD_DIR}/www"

# -----------------------------------------------------------------------------
#  Set env
# -----------------------------------------------------------------------------
PATH="$PATH:${HOST_BIN_DIR}"
export PATH

LC_ALL=C
export LC_ALL

unset INFODIR
unset LESSCHARSET
unset MAKEFLAGS
unset TERMINFO

MACHINE_ARCH=i386
MACHINE_CPU=i386
MACHINE_BOARD=generic

DISTRIBVER=$(git describe 2>/dev/null || echo -n "0.0")

DESTDIR="${BUILD_DIR}/${MACHINE_ARCH}-${MACHINE_BOARD}-${MACHINE_CPU}"
MAKEOBJDIRPREFIX=""

# -----------------------------------------------------------------------------
# global variable
# -----------------------------------------------------------------------------
qdn_do_rebuild_bmake=false
qdn_do_config=false

# -----------------------------------------------------------------------------
# log reporting
# -----------------------------------------------------------------------------
error() {
	echo -e "\033[31m[-] $@\033[0m"
	exit 1
}

warning() {
	echo -e "\033[33m[!] $@\033[0m"
}

success() {
	echo -e "\033[32m[+] $@\033[0m"
}

# -----------------------------------------------------------------------------
#  Supported machine and arch
# -----------------------------------------------------------------------------
supported_machine='
MACHINE=athenasim MACHINE_ARCH=athena
MACHINE=malta     MACHINE_ARCH=mips
MACHINE=mipssim   MACHINE_ARCH=mips
MACHINE=nrf52dk   MACHINE_ARCH=arm
MACHINE=pc        MACHINE_ARCH=i386     DEFAULT
MACHINE=pdp11     MACHINE_ARCH=pdp11
MACHINE=virt      MACHINE_ARCH=riscv64
'


# -----------------------------------------------------------------------------
#  Rebuild tools
# -----------------------------------------------------------------------------
rebuild_make() {
	if ${qdn_do_rebuild_bmake}; then
		(cd thirdparty/bsd3/bmake/dist; \
		./configure --with-default-sys-path="${SRC_DIR}/share/mk" \
			--prefix="$HOST_DIR"; \
		make; \
		make install)

		date > "${HOST_DIR}/update"
	fi
}

# -----------------------------------------------------------------------------
#  entry 
# -----------------------------------------------------------------------------
print_help() {
	cat <<EOF
Usage: $PRGNAME COMMANDS [OPTIONS...]
Commands:
	config
	build
	www
Options:

EOF

	exit 0
}

main() {
	build_start="$(date)"
	[ -f "${HOST_BIN_DIR}/bmake" ] || qdn_do_rebuild_bmake=true
	if [ -f .config ]; then
		. ./.config
	else
		qdn_do_config=yes
	fi
	
	rebuild_make

	while [ $# -gt 0 ]; do
		op=$1; shift
		
		case "${op}" in
		help)
			print_help
			;;
		www)
			DESTDIR="${WEBSITE_DIR}" "${HOST_BIN_DIR}/bmake" www
			;;
		tools)
			;;
		build)
			export DESTDIR
			MAKEOBJDIR=obj.${MACHINE}.${TARGET} "${HOST_BIN_DIR}/bmake" build
			;;
		esac
	done
}

main "$@"
