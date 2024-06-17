#!/usr/bin/env python3

# BSD 3-Clause License
#
# Copyright (c) 2021, The µnix Contributors
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import sys
import kconfiglib
import menuconfig
import argparse
from kconfiglib import _BOOL_TRISTATE, STRING, HEX, escape

kconfig = None
try:
    kconfig = kconfiglib.Kconfig("Kconfig")
except kconfiglib.KconfigError as e:
    print(e)
    sys.exit(-1)

def generate_header(dest):
    kconfig.load_config('.config')
    kconfig.write_autoconf(
        dest, '#ifndef _QDNIX_CONFIG_H\n'
              '#define _QDNIX_CONFIG_H\n\n')
    # a bit hacky but there is no other way and I really hate '#pragma once'
    with open(dest, 'a') as f:
        f.write('\n#endif /* !_QDNIX_CONFIG_H */\n')

def _makefile_contents():

    chunks = []  # "".join()ed later
    add = chunks.append

    for sym in kconfig.unique_defined_syms:
        val = sym.str_value
        if not sym._write_to_conf:
            continue

        if sym.orig_type in _BOOL_TRISTATE:
            if val == "y":
                add("{}{}=yes\n"
                    .format(kconfig.config_prefix, sym.name))
            elif val == "m":
                add("{}{}_MODULE=yes\n"
                    .format(kconfig.config_prefix, sym.name))

        elif sym.orig_type is STRING:
            add('{}{}={}\n'
                .format(kconfig.config_prefix, sym.name, escape(val)))

        else:  # sym.orig_type in _INT_HEX:
            if sym.orig_type is HEX and \
               not val.startswith(("0x", "0X")):
                val = "0x" + val

            add("{}{}={}\n"
                .format(kconfig.config_prefix, sym.name, val))

    return "".join(chunks)

def generate_make(dest):
    kconfig.load_config('.config')
    with open(dest, "w") as f:
        print(f"write {dest}")
        f.write(_makefile_contents())

def generate_config(dest):
    kconfig.load_config('.config')
    kconfig.write_config(dest)

def defconfig():
    kconfig.write_config()


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--genheader', action='store', default=None)
    parser.add_argument('--genmake', action='store', default=None)
    parser.add_argument('--menuconfig', action='store_true')
    parser.add_argument('--defconfig', action='store_true')
    parser.add_argument('--update', action='store_true')
    args = parser.parse_args()

    if args.genheader is not None:
        generate_header(args.genheader)

    if args.genmake is not None:
        generate_make(args.genmake)

    if args.menuconfig:
        menuconfig.menuconfig(kconfig)

    if args.update:
        generate_config(".config")

    if args.defconfig:
        defconfig()

