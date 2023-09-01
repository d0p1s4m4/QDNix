#!/bin/sh

set -e

PRGNAME=$(basename "$0")

# -----------------------------------------------------------------------------
#  Setup env
# -----------------------------------------------------------------------------
init_default() {
	[ -d thirdparty/bsd3/bmake/dist ] || cd "$(dirname $0)"
	[ -d thirdparty/bsd3/bmake/dist ] ||
		error "bmake not found; build.sh must be run from the top \
level of source directory"

	TOP_DIR="$(pwd)"
	BUILD_DIR="$(pwd)/build"
	HOST_DIR="${BUILD_DIR}/host"
	HOST_BIN_DIR="${HOST_DIR}/bin"
	SRC_DIR="$(pwd)/src"
	WEBSITE_DIR="${BUILD_DIR}/www"

	qdn_do_rebuild_bmake=false
	qdn_do_config=false
	qdn_uname_s=$(uname -s 2>/dev/null)
	qdn_uname_r=$(uname -r 2>/dev/null)
	qdn_uname_m=$(uname -m 2>/dev/null)
	qdn_uname_p=$(uname -p 2>/dev/null || echo "unknown")
	case "${qdn_uname_p}" in
		''|unknown|*[!-_A-Za-z0-9]*) uname_p="${qdn_uname_m}" ;;
	esac

	PATH="$PATH:${HOST_BIN_DIR}"
	export PATH

	LC_ALL=C
	export LC_ALL

	QDNIXSRCDIR="$TOP_DIR"
	export QDNIXSRCDIR

	unset INFODIR
	unset LESSCHARSET
	unset MAKEFLAGS
	unset TERMINFO

	MACHINE_ARCH=i386
	MACHINE_CPU=i386
	MACHINE_BOARD=generic

	DISTRIBVER=$(git describe 2>/dev/null || echo -n "0.0")
	export DISTRIBVER

	[ -f .config ] && . "$(dirname $0)/.config"

	QDNIX_BUILD_DIR=${BUILD_DIR}
	export QDNIX_BUILD_DIR

	DESTDIR="${BUILD_DIR}/distro/${MACHINE_ARCH}-${MACHINE_BOARD}-${MACHINE_CPU}"
}

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
MACHINE=pc        MACHINE_ARCH=amd64
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

buildtools() {
	echo
}

buildlibs() {
	echo
}

buildkernel() {
	echo
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
	init_default
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
			(cd website ; emacs --script publish.el)
			doxygen
			;;
		tools)
			;;
		build)
			export DESTDIR
			;;
		esac
	done
}

main "$@"
