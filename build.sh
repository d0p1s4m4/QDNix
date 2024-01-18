#!/bin/sh

set -e

LC_ALL=C
export LC_ALL

unset INFODIR
unset LESSCHARSET
unset MAKEFLAGS
unset TERMINFO

PRGNAME="${0##*/}"

TOP_DIR="$(realpath '$0' | dirname)"

BUILD_DIR="${TOP_DIR}/build"
BUILD_HOST_DIR="${BUILD_DIR}/host"
BUILD_HOST_BIN_DIR="${HOST_DIR}/bin"
BUILD_WEBSITE_DIR="${BUILD_DIR}/www"

DISTRIB_DIR=""

qdn_do_rebuild_bmake=0
qdn_do_config=0

qdn_uname_s="$(uname -s 2>/dev/null)"
qdn_uname_r="$(uname -r 2>/dev/null)"
qdn_uname_m="$(uname -m 2>/dev/null)"
qdn_uname_p="$(uname -p 2>/dev/null || echo 'unknown')"
case "${qdn_uname_p}" in
    ''|unknown|*[!-_A-Za-z0-9]*) uname_p="${qdn_uname_m}" ;;
esac

PATH="${PATH}:${BUILD_HOST_BIN_DIR}"
export PATH

DISTRIBVER=$(git describe 2>/dev/null || echo -n "0.0")
export DISTRIBVER

# --------------------------------------------------------------------
# log reporting
# --------------------------------------------------------------------
error() {
    printf "\033[31m[-] %s\033[0m\n" "$@"
    exit 1
}

warning() {
    printf "\033[33m[!] %s\033[0m\n" "$@"
}

success() {
    printf "\033[32m[+] %s\033[0m\n" "$@"
}

# --------------------------------------------------------------------
#  Rebuild tools
# --------------------------------------------------------------------
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

# --------------------------------------------------------------------
#  entry
# --------------------------------------------------------------------
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
