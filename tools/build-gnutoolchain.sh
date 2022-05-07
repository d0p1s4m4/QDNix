#!/bin/bash

BINUTILS_VERSION=2.38
BINUTILS_ARCHIVE="binutils-${BINUTILS_VERSION}.tar.gz"
BINUTILS_URL="https://ftp.gnu.org/gnu/binutils/${BINUTILS_ARCHIVE}"
BINUTILS_SHA256="b3f1dc5b17e75328f19bd88250bee2ef9f91fc8cbb7bd48bdb31390338636052"

GCC_VERSION=12.1.0
GCC_ARCHIVE="gcc-${GCC_VERSION}.tar.gz"
GCC_URL="https://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/${GCC_ARCHIVE}"
GCC_SHA256="e88a004a14697bbbaba311f38a938c716d9a652fd151aaaa4cf1b5b99b90e2de"

MPFR_VERSION=4.1.0
MPFR_ARCHIVE="mpfr-${MPFR_VERSION}.tar.gz"
MPFR_URL="https://ftp.gnu.org/gnu/mpfr/${MPFR_ARCHIVE}"
MPFR_SHA256="3127fe813218f3a1f0adf4e8899de23df33b4cf4b4b3831a5314f78e65ffa2d6"

MPC_VERSION=1.2.1
MPC_ARCHIVE="mpc-${MPC_VERSION}.tar.gz"
MPC_URL="https://ftp.gnu.org/gnu/mpc/${MPC_ARCHIVE}"
MPC_SHA256="17503d2c395dfcf106b622dc142683c1199431d095367c6aacba6eec30340459"

GMP_VERSION=6.2.1
GMP_ARCHIVE="gmp-${GMP_VERSION}.tar.xz"
GMP_URL="https://ftp.gnu.org/gnu/gmp/${GMP_ARCHIVE}"
GMP_SHA256="fd4829912cddd12f84181c3451cc752be224643e87fac497b69edddadc49b4f2"

PREFIX="$(pwd)/.toolchain"
PATH="${PREFIX}/bin:${PATH}"

verify() {
	sha256sum -c <(echo "$1" "$2") > /dev/null && echo -n "OK"
}

download() {
	if [ ! -f "$2" ] || [ ! $(verify "$3" "$2") = "OK" ]; then
		wget "$1" -O "$2"
		[ $(verify "$3" "$2") = "OK" ] || exit -1
	fi

	tar -xf "$2"
}

if [ -z ${ARCH+x} ]; then
	ARCH=arm
fi

if [ "$ARCH" = "arm" ]; then
	TARGET="${ARCH}-none-eabi"
else
	TARGE="$ARCH-elf"
fi

mkdir -p "$PREFIX"

if [ ! -f "${PREFIX}/bin/${TARGET}" ]; then
	cd "$PREFIX"
	download "$GCC_URL" "$GCC_ARCHIVE" "$GCC_SHA256"
	download "$BINUTILS_URL" "$BINUTILS_ARCHIVE" "$BINUTILS_SHA256"
	download "$MPFR_URL" "$MPFR_ARCHIVE" "$MPFR_SHA256"
	download "$MPC_URL" "$MPC_ARCHIVE" "$MPC_SHA256"
	download "$GMP_URL" "$GMP_ARCHIVE" "$GMP_SHA256"

	pushd "binutils-${BINUTILS_VERSION}" && mkdir -p build && pushd "build"
	../configure --target="$TARGET" --prefix="$PREFIX" \
		--with-sysroot --disable-nls --disable-werror
	make -j $(nproc)
	make install
	popd && popd

	mv "mpfr-${MPFR_VERSION}" "gcc-${GCC_VERSION}/mpfr"
	mv "mpc-${MPC_VERSION}" "gcc-${GCC_VERSION}/mpc"
	mv "gmp-${GMP_VERSION}" "gcc-${GCC_VERSION}/gmp"

	pushd "gcc-${GCC_VERSION}" && mkdir -p build && pushd "build"
	../configure --target="$TARGET" --prefix="$PREFIX" \
		--disable-nls --enable-languages=c --without-headers
	make all-gcc
	make all-target-libgcc
	make install-gcc
	make install-target-libgcc
    popd && popd
fi
