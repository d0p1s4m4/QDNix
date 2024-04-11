#!/usr/bin/env bash

echo "% Manual page index"
echo

sections=(
	""
	"General Commands"
	"System Calls"
	"C Library Functions"
	"Special files and devices"
	"File formats and conventions"
	"User contributed"
	"Miscellaneous Information"
	"System administration"
	"Kernel developper's manual"
)

for i in {1..9}; do
	echo
	echo "### System Section ${i} - ${sections[$i]}"
	echo
	for m in "${DESTDIR}/html/man/man${i}/"*.html; do
		m=$(basename "${m}" .html)
		echo "- [${m}(${i})](/man/man${i}/${m}.html)"
	done
done
