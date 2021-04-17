#!/bin/bash
# Android NDK must be somewhere in your path

ncursesvers=6.0
nanovers=5.6.1

nanoMajorVers=$(echo $nanovers | cut -d . -f 1)
nanoMinorVers=$(echo $nanovers | cut -d . -f 2)
nanoPatchVers=$(echo $nanovers | cut -d . -f 3)
[ -z "$nanoPatchVers" ] && nanoPatchVers=0

[ ! -f nano-$nanovers.tar.xz ] && {
  echo "Getting nano..."
  wget -q https://nano-editor.org/dist/v$nanoMajorVers/nano-$nanovers.tar.xz
}

[ ! -d nano ] && {
  echo "Unpacking nano..."
  tar -xf nano-$nanovers.tar.xz
  mv nano-$nanovers nano
}

cd nano

[ -f config.h ] || {
  echo "Getting extra nano files..."
  wget -q -O config.h https://github.com/LineageOS/android_external_nano/raw/lineage-16.0/config.h
  sed -i config.h -e 's|#define HAVE_PWD_H 1|/* #undef HAVE_PWD_H */|g'
  sed -i config.h -e 's|#define PACKAGE_STRING "GNU nano 4.3"|/* #undef PACKAGE_STRING */|g'
  sed -i config.h -e 's|#define PACKAGE_VERSION "4.3"|/* #undef PACKAGE_VERSION */|g'
  sed -i config.h -e 's|#define VERSION "4.3"|/* #undef VERSION */|g'
  echo '#define PACKAGE_STRING "'$(grep PACKAGE_STRING= configure | cut -d = -f 2 | sed "s/'//g")'"' >> config.h
  echo '#define PACKAGE_VERSION "'$(grep PACKAGE_VERSION= configure | cut -d = -f 2 | sed "s/'//g")'"' >> config.h
  echo '#define VERSION "'$(grep ' VERSION=' configure | cut -d = -f 2 | sed "s/'//g")'"' >> config.h
  # apply the patch needed for Android versions without futimes
  [ $nanoMajorVers -eq 4 -a $nanoMinorVers -eq 9 -a $nanoPatchVers -lt 3 ] && {
    patch -b -p 1 -i ../nano-4.9.2.patch
  } || {
    patch -b -p 1 -i ../nano-4.9.3.patch
  }
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
