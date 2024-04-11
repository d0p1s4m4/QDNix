#!/usr/bin/env python3

import argparse
import hashlib
import sys

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers()
    verifyparser = subparsers.add_parser('verify')

    verifyparser.add_argument('-f', '--file', action='store', required=True)
    verifyparser.add_argument('-H', '--hash', action='store', required=True)
    verifyparser.add_argument('-a', '--algo', choices=hashlib.algorithms_guaranteed, default="sha256")
    args = parser.parse_args()

    h = hashlib.new(args.algo)
    with open(args.file, 'rb') as f:
        h.update(f.read())
    if h.hexdigest() != args.hash:
        sys.exit(1)

