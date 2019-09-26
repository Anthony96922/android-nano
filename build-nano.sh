#!/bin/bash
# Android NDK must be somewhere in your path

ncursesvers=6.0
nanovers=4.3

[ ! -f nano-$nanovers.tar.xz ] && {
  echo "Getting nano..."
  wget -q https://nano-editor.org/dist/v4/nano-$nanovers.tar.xz
}

[ ! -d nano ] && {
  echo "Unpacking nano..."
  tar -xf nano-$nanovers.tar.xz
  mv nano-$nanovers nano
}

cd nano

[ -f config.h ] || {
  echo "Getting extra nano files..."
  wget -q -O - https://github.com/LineageOS/android_external_nano/raw/lineage-16.0/config.h | \
    sed -e 's|#define HAVE_PWD_H 1|/* #undef HAVE_PWD_H 1 */|g' > config.h
  # apply the patch needed for Android versions without futimes
  patch -b -p 0 -i ../nano.patch
}
[ -f revision.h ] || > revision.h

[ ! -f ncurses-$ncursesvers.tar.gz ] && {
  echo "Getting ncurses..."
  wget -q ftp://ftp.gnu.org/gnu/ncurses/ncurses-$ncursesvers.tar.gz
}

[ ! -d ncurses ] && {
  echo "Unpacking ncurses..."
  tar -xf ncurses-$ncursesvers.tar.gz
  mv ncurses-$ncursesvers ncurses
}

cd ncurses
# patch to disable duplicate main() in make_hash.c for static exe
[ -f ncurses/tinfo/make_hash.c.orig ] || patch -b -p 0 -i ../../ncurses.patch

[ -f ncurses/codes.c ] || echo -n "Getting extra ncurses files"
for file in ncurses/codes.c ncurses/comp_captab.c ncurses/expanded.c ncurses/fallback.c ncurses/init_keytry.h ncurses/lib_gen.c ncurses/lib_keyname.c ncurses/names.c ncurses/unctrl.c include/curses.h include/hashsize.h include/ncurses_cfg.h include/ncurses_def.h include/ncurses_dll.h include/parametrized.h include/termcap.h include/term.h include/unctrl.h; do
  [ -f $file ] || {
    wget -q -O $file \
      https://github.com/LineageOS/android_external_libncurses/raw/lineage-16.0/$file && echo -n .
  }
done
cd ..

[ ! -d glob ] && {
  echo
  echo "Getting libglob..."
  mkdir glob
  cd glob
  bioniclocation=https://github.com/aosp-mirror/platform_bionic/raw/master/libc
  wget -q -O freebsd-compat.h $bioniclocation/upstream-freebsd/android/include/freebsd-compat.h
  wget -q -O glob.c $bioniclocation/upstream-freebsd/lib/libc/gen/glob.c
  wget -q -O glob.h $bioniclocation/include/glob.h
  > collate.h
  patch -b -i ../../glob.patch
  cd ..
}

[ ! -d jni ] && {
  mkdir jni
  cd jni
  ln -s ../../Application.mk .
  cd ..
}

# build static exe (no need to use LD_LIBRARY_PATH)
[ -s Android.mk ] || ln -s ../Android-static.mk Android.mk

echo "Now building..."
NDK_PROJECT_PATH=$PWD ndk-build
cd ..
[ -d out ] || mkdir out
[ -f nano/libs/armeabi-v7a/nano ] && mv nano/libs/armeabi-v7a/* out/
echo "Done!"
