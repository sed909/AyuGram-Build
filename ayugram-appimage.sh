#!/bin/sh

set -eux

ARCH="$(uname -m)"
URUNTIME="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/uruntime2appimage.sh"
SHARUN="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/quick-sharun.sh"

export VERSION=$(cat ./version)
export ICON="https://raw.githubusercontent.com/AyuGram/AyuGramDesktop/refs/heads/dev/Telegram/Resources/art/icon256.png"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export OUTNAME=AyuGram-"$VERSION"-anylinux-"$ARCH".AppImage
export DEPLOY_OPENGL=1
export DEPLOY_VULKAN=1
export DEPLOY_PIPEWIRE=1
export DEPLOY_QT=1


strip -s -R .comment --strip-unneeded ./AppDir/bin/AyuGram

wget --retry-connrefused --tries=30 "$SHARUN" -O ./quick-sharun
chmod +x ./quick-sharun
./quick-sharun ./AppDir/bin/AyuGram


wget --retry-connrefused --tries=30 "$URUNTIME" -O ./uruntime2appimage
chmod +x ./uruntime2appimage
./uruntime2appimage

wget --retry-connrefused --tries=30 \
	"https://github.com/xplshn/pelf/releases/latest/download/pelf_$ARCH" -O ./pelf
chmod +x ./pelf

echo "Generating [dwfs]AppBundle...(Go runtime)"
./pelf --add-appdir ./AppDir \
	--appbundle-id="AyuGram-$VERSION" \
	--compression "-C zstd:level=22 -S26 -B8" \
	--output-to "AyuGram-$VERSION-anylinux-$ARCH.dwfs.AppBundle" \
	--disable-use-random-workdir

zsyncmake *.AppBundle -u *.AppBundle
