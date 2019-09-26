#!/bin/bash
# script to get terminfo files

# From https://github.com/LineageOS/android_external_libncurses/blob/lineage-16.0/Android.mk
terminfofiles="a/ansi c/cons25 c/cygwin d/dumb E/Eterm E/Eterm-color h/hurd l/linux
	m/mach m/mach-bold m/mach-color p/pcansi r/rxvt r/rxvt-basic
	s/screen s/screen-bce s/screen-s s/screen-w s/sun
	s/screen-256color s/screen-256color-bce v/vt100 v/vt102
	v/vt220 v/vt52 x/xterm x/xterm-xfree86 x/xterm-color x/xterm-r5 x/xterm-r6
	x/xterm-vt220 x/xterm-256color w/wsvt25 w/wsvt25m"

[ -d terminfo ] || mkdir terminfo
cd terminfo

for file in $terminfofiles; do
  [ -f $file ] && echo "Already have $file" || {
    echo "Getting $file..."
    dir=$(dirname $file)
    [ ! -d $dir ] && mkdir $dir
    wget -q -O $file https://github.com/LineageOS/android_external_libncurses/raw/lineage-16.0/lib/terminfo/$file
  }
done

echo "done"
