#!/usr/bin/env bash

set -e

# -----------------------------------------------------------------------------
# log reporting
# -----------------------------------------------------------------------------
plain() {
	local mesg=$1; shift

	# shellcheck disable=SC2059
	printf "${BOLD}    ${mesg}${ALL_OFF}\n" "$@"
}

msg() {
	local mesg=$1; shift

	# shellcheck disable=SC2059
	printf "${MAGENTA}==>${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@"
}

msg2() {
	local mesg=$1; shift

	# shellcheck disable=SC2059
	printf "${BLUE} ->${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@"
}

error() {
	local mesg=$1; shift

	# shellcheck disable=SC2059
	printf "${RED}==> ERROR:${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@"
	exit 1
}

warning() {
	local mesg=$1; shift

	# shellcheck disable=SC2059
	printf "${YELLOW}==> WARNING:${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@"
}

success() {
	local mesg=$1; shift

	# shellcheck disable=SC2059
	printf "${GREEN}==> SUCCESS:${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@"
}

# -----------------------------------------------------------------------------
#  utils
# -----------------------------------------------------------------------------
verify() {
	python3 "${topdir}/tools/hash.py" verify -a sha256 -H "$1" -f "$2" && echo -n "OK"
}

download_and_verify() {
	if [ ! -f "$2" ] || [ ! "$(verify "$3" "$2")" == "OK" ]; then
		msg2 "Download %s" "$2"
		curl -L -o "$2" "$1"
		[ "$(verify "$3" "$2")" == "OK" ]  || error "sha256sum missmatch"
    fi
}

cmd_make() {
	local rule=$1

	msg "Run ${TOOLS_PREFIX}bmake ${rule}"
	"${TOOLS_PREFIX}bmake" "${rule}" || error "Can't make '${rule}'"
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
	msg2 "Generate sitemap.xml"
	"${topdir}"/tools/site-map-gen.sh "${topdir}/website/generated" > "${topdir}/website/generated/sitemap.xml"
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
	download_and_verify "${bmake_url}" "${TOOLS_DIR}/bmake.zip" "${bmake_sha256sum}"

	bmakebuilddir="$(mktemp -d)"
	unzip -d "${bmakebuilddir}" "${TOOLS_DIR}/bmake.zip"

	(cd "${bmakebuilddir}/"bmake-*;
		./configure --with-default-sys-path="${topdir}/share/mk" --prefix="${TOOLS_DIR}" &&
		make && make install)
	mv -f "${TOOLS_DIR}/bin/bmake" "${TOOLS_DIR}/bin/${TOOLS_PREFIX}bmake" || error "Can't build bmake"
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

	cmd_make fetch

	cmd_make do-tools

	success "BUILD FINISHED"
	plain "Started: %s" "${build_start}"
	plain "Ended:   %s" "$(date)"
}

# -----------------------------------------------------------------------------
#  build os
# -----------------------------------------------------------------------------
do_build_os() {
	msg  "Building"
	plain "%s started: %s" "${prgname}" "${build_start}"
	plain "MACHINE: %s" "${CONFIG_ARCH}"
	plain "BOARD: %s" "${CONFIG_BOARD}"
	plain "Build platform: %s %s %s" "${uname_s}" "${uname_r}" "${uname_m}"

	msg2 "Checking deps"
	command -v "${TOOLS_PREFIX}bmake" || do_build_bmake
	command -v python3 || error "python3 not found"
	[ -f "${topdir}/tools/config.py" ] || error "config.py not found"

	msg2 "Generate headers"
	python3 "${topdir}/tools/config.py" --genheader "${topdir}/config.h" --genmake "${topdir}/.config.mk"

	msg2 "Build"

	DESTDIR=${BUILD_DIR}/${CONFIG_ARCH}/${CONFIG_BOARD} cmd_make build

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
	-m MACHINE     (default: $MACHINE)
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
if [ -z "${NO_COLOR+x}" ]; then
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
prgname="$(basename "$0")"
topdir="$(realpath "$0")"
topdir="$(dirname "${topdir}")"
build_start="$(date)"
uname_m="$(uname -m)"
uname_r="$(uname -r)"
uname_s="$(uname -s)"
readonly topdir prgname build_start uname_m uname_r uname_s

[ -f build.sh ] || cd "${topdir}"
[ -f build.sh ] || error "build.sh must be run from the top \
level of source directory"

# set default value
QDNIXSRCDIR="${topdir}"
MKCONF="${topdir}/.config.mk"
BUILD_DIR="${topdir}/.build"
TOOLS_DIR="${topdir}/.tools"
TOOLS_PREFIX="qdn-"
MACHINE="i386"
BOARD="pc"

unset qdnix_build_website qdnix_build_tools qdnix_config qdnix_build_os

if [ $# -eq 0 ]; then
	printf "Try '%s -h' for more information.\n" "${prgname}" >&2
	exit 1
fi

while [ $# -gt 0 ]; do
	op=$1; shift

	case "${op}" in
		help | --help | -h) usage ;;
		www) qdnix_build_website=yes ;;
		tools) qdnix_build_tools=yes ;;
		config) qdnix_config=yes ;;
		build) qdnix_build_os=yes ;;
		-o) BUILD_DIR="$1"; shift ;;
		-t) TOOLS_DIR="$1"; shift ;;
		-p) TOOLS_PREFIX="$1"; shift ;;
		-c) cp "$1" "${topdir}/.config"; shift ;;
		-b) BOARD="$1"; shift ;;
		-m) MACHINE="$1"; shift ;;
		*)
			printf "Try '%s -h' for more information.\n" "${prgname}" >&2
			exit 1
			;;
	esac
done

if [ ! -f "${topdir}/.config" ]; then
	cp "${topdir}/sys/${MACHINE}/conf/${MACHINE}-${BOARD}.conf" "${topdir}/.config"
fi

python3 "${topdir}/tools/config.py" --update

# shellcheck disable=SC1091
. "${topdir}/.config"

mkdir -p "${BUILD_DIR}"
mkdir -p "${TOOLS_DIR}"

readonly QDNIXSRCDIR BUILD_DIR TOOLS_DIR TOOLS_PREFIX MKCONF
export QDNIXSRCDIR BUILD_DIR TOOLS_DIR TOOLS_PREFIX MKCONF

PATH="${TOOLS_DIR}/bin:${PATH}"
export PATH

if [ "${qdnix_build_website}" = "yes" ]; then do_build_website; fi
if [ "${qdnix_build_tools}" = "yes" ]; then do_build_tools; fi
if [ "${qdnix_config}" = "yes" ]; then do_config; fi
if [ "${qdnix_build_os}" = "yes" ]; then do_build_os; fi
