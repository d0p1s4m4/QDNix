#!/bin/bash

set -e

# -----------------------------------------------------------------------------
# log reporting
# -----------------------------------------------------------------------------
plain() {
	local mesg=$1; shift
	printf "${BOLD}    ${mesg}${ALL_OFF}\n" "$@"
}

msg() {
	local mesg=$1; shift
	printf "${MAGENTA}==>${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@"
}

msg2() {
	local mesg=$1; shift
	printf "${BLUE} ->${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@"
}

error() {
	local mesg=$1; shift
	printf "${RED}==> ERROR:${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@"
	exit 1
}

warning() {
	local mesg=$1; shift
	printf "${YELLOW}==> WARNING:${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@"
}

success() {
	local mesg=$1; shift
	printf "${GREEN}==> SUCCESS:${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@"
}

# -----------------------------------------------------------------------------
#  utils
# -----------------------------------------------------------------------------
verify() {
	sha256sum -c <(echo "$1" "$2") > /dev/null && echo -n "OK"
}

download_and_verify() {
	msg2 "Download %s" "$2"
	if [ ! -f "$2" ] || [ ! "$(verify $3 $2)" == "OK" ]; then
		wget "$1" -O "$2"
		[ "$(verify $3 $2)" == "OK" ]  || error "sha256sum missmatch"
    fi
}

cmd_make() {
	local rule=$1

	msg "Run ${TOOLS_PREFIX}bmake $1"
	"${TOOLS_PREFIX}bmake" "$1" || error "Can't make '$1'"
}

# -----------------------------------------------------------------------------
#  build website
# -----------------------------------------------------------------------------
do_build_website() {
	msg "Building website"
	msg2 "Checking deps"
	command -v emacs || error "emacs not found"
	command -v doxygen || error "doxygen not found"
	msg2 "Building mainsite"
	(cd website ; emacs --script publish.el)
	msg2 "Building docs"
	doxygen
	success "BUILD FINISHED"
	plain "Started: %s" "${build_start}"
	plain "Ended:   %s" "$(date)"
}

# -----------------------------------------------------------------------------
#  run menuconfig
# -----------------------------------------------------------------------------
do_config() {
	msg "Config"
	msg2 "Checking deps"
	command -v python3 || error "python3 not found"
	[ -f "${topdir}/tools/config.py" ] || error "config.py not found"
	msg2 "Running menuconfig"
	python3 "${topdir}/tools/config.py" --menuconfig || error "menuconfig ???"
	msg2 "Generate headers"
	python3 "${topdir}/tools/config.py" --genheader "${topdir}/config.h" --genmake "${topdir}/.config.mk"
	success "CONFIG FINISHED"
}

# -----------------------------------------------------------------------------
#  build tools
# -----------------------------------------------------------------------------
bmake_url="https://github.com/d0p1s4m4/bmake/archive/c6c5f62be8952fb824316edbc8ea481f720beb0c.zip"
bmake_sha256sum="a4ca49426c1ea5a2c5fbe4405bf6240696b1e25b99174813cd0034177ab8c71e"

do_build_bmake() {
	msg2 "Building ${TOOLS_PREFIX}bmake"
	(cd $(mktemp -d);
		download_and_verify "${bmake_url}" "bmake.zip" "${bmake_sha256sum}";
		unzip "bmake.zip" || error "Can't unzip bmake.zip";
		(cd bmake-*;
			./configure --with-default-sys-path="${topdir}/src/share/mk" --prefix="${TOOLS_DIR}" &&
			make && make install))
	mv -u "${TOOLS_DIR}/bin/bmake" "${TOOLS_DIR}/bin/${TOOLS_PREFIX}bmake" || error "Can't build bmake"
}

do_build_tools() {
	msg "Building tools"
	plain "tools prefix: $TOOLS_PREFIX"
	plain "tools dir: $TOOLS_DIR"

	msg2 "Checking deps"
	command -v wget || error "wget not found"
	command -v unzip || error "unzip not found"
	command -v python3 || error "python3 not found"
	[ -f "${topdir}/tools/config.py" ] || error "config.py not found"

	msg2 "Generate headers"
	python3 "${topdir}/tools/config.py" --genheader "${topdir}/config.h" --genmake "${topdir}/.config.mk"

	command -v "${TOOLS_PREFIX}bmake" || do_build_bmake

	cmd_make "do-tools-obj"

	cmd_make "do-tools"

	success "BUILD FINISHED"
	plain "Started: %s" "${build_start}"
	plain "Ended:   %s" "$(date)"
}

# -----------------------------------------------------------------------------
#  build os
# -----------------------------------------------------------------------------
do_build_os() {
	msg "Building for ${CONFIG_ARCH}"
	msg2 "Checking deps"
	command -v "${TOOLS_PREFIX}bmake" || error "${TOOLS_PREFIX}bmake not found"
	command -v python3 || error "python3 not found"
	[ -f "${topdir}/tools/config.py" ] || error "config.py not found"

	msg2 "Generate headers"
	python3 "${topdir}/tools/config.py" --genheader "${topdir}/config.h" --genmake "${topdir}/.config.mk"

	success "BUILD FINISHED"
	plain "Started: %s" "${build_start}"
	plain "Ended:   %s" "$(date)"
}

# -----------------------------------------------------------------------------
#  usage 
# -----------------------------------------------------------------------------
usage() {
	cat <<EOF
Usage: $prgname COMMANDS [OPTIONS...]
Commands:
	config
	tools
	build
	www
Options:
	-o BUILDDIR    (default: $BUILD_DIR)
	-t TOOLSDIR    (default: $TOOLS_DIR)
	-p TOOLSPREFIX (default: $TOOLS_PREFIX)
	-c CONFIG      
EOF

	exit 0
}

# -----------------------------------------------------------------------------
#  entry 
# -----------------------------------------------------------------------------
LC_ALL=C
export LC_ALL

unset INFODIR
unset LESSCHARSET
unset MAKEFLAGS
unset TERMINFO

unset ALL_OFF BOLD RED GREEN BLUE MAGENTA YELLOW
if [[ ! -v NO_COLOR ]]; then
	ALL_OFF="\e[1;0m"
	BOLD="\e[1;1m"
	BLUE="${BOLD}\e[1;34m"
	GREEN="${BOLD}\e[1;32m"
	RED="${BOLD}\e[1;31m"
	MAGENTA="${BOLD}\e[1;35m"
	YELLOW="${BOLD}\e[1;33m"
fi
readonly ALL_OFF BOLD RED GREEN BLUE MAGENTA YELLOW

unset topdir prgname build_start
prgname="$(basename $0)"
topdir="$(realpath "$0")"
topdir="$(dirname "${topdir}")"
build_start="$(date)"
readonly topdir prgname build_start

[ -f build.sh ] || cd "${topdir}"
[ -f build.sh ] || error "build.sh must be run from the top \
level of source directory"

# set default value
QDNIXSRCDIR="${topdir}"
BUILD_DIR="${topdir}/.build"
TOOLS_DIR="${topdir}/.tools"
TOOLS_PREFIX="qdn-"
CONFIG_ARCH="i386"

unset qdnix_build_website qdnix_build_tools qdnix_config qdnix_build_os

if [ $# -eq 0 ]; then
	printf "Try '%s -h' for more information.\n" "${prgname}" >&2
	exit 1
fi

while [ $# -gt 0 ]; do
	op=$1; shift

	case "${op}" in
		help | --help | -h) usage ;;
		www) qdnix_build_website=1 ;;
		tools) qdnix_build_tools=1 ;;
		config) qdnix_config=1 ;;
		build) qdnix_build_os=1 ;;
		-o) BUILD_DIR="$1"; shift ;;
		-t) TOOLS_DIR="$1"; shift ;;
		-p) TOOLS_PREFIX="$1"; shift ;;
		-c) cp "$1" "${topdir}/.config"; shift ;;
		*)
			printf "Try '%s -h' for more information.\n" "${prgname}" >&2
			exit 1
			;;
	esac
done

[ -f "${topdir}/.config" ] && source .config

mkdir -p "${BUILD_DIR}"
mkdir -p "${TOOLS_DIR}"

export QDNIXSRCDIR BUILD_DIR TOOLS_DIR

PATH="${TOOLS_DIR}/bin:${PATH}"
export PATH

[ -v "qdnix_build_website" ] && do_build_website || true
[ -v "qdnix_build_tools" ] && do_build_tools || true
[ -v "qdnix_config" ] && do_config || true
[ -v "qdnix_build_os" ] && do_build_os || true
