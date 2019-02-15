#! /bin/bash

[ "$2" ] || ! echo "Usage: $0 <arm-sysroot> lib_path1 ..." || exit 1

armsysroot="$1"
shift
paths="$@"

find_needed () { "${T_ARCH}-readelf" -d "$1" | sed -Ene '/NEEDED/s~^.*\[(.*)\].*$~\1~p'; } 2>/dev/null

is_needed () { find_needed "$1" | grep -q "$2"; }

cntold=-1
cnt=0
while [ "$cnt" -gt "$cntold" ]; do
	cntold="$cnt"
	find "$armsysroot" -type f | while read f; do find_needed "$f"; done | awk '!seen[$0]++' | while read l; do
		[ -f "$armsysroot/lib/$l" ] || [ -f "initramfs/lib/$l" ] && echo "$l" is already installed && continue
		found=''
		for p in $paths; do
			[ -f "$p/$l" ] && found=1 && echo found "$p/$l" && cp "$p/$l" "$armsysroot/lib/" && break
		done
		[ "$found" ] || ! echo WARNING - cannot find "$l" used in: || find "$armsysroot" -type f | while read f; do is_needed "$f" "$l" && echo " $f"; done
	done
	cnt="$(ls -1 "$armsysroot/lib" | wc -l)"
done
