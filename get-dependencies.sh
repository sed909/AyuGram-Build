#!/bin/sh

set -ex
EXTRA_PACKAGES="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/get-debloated-pkgs.sh"

echo "Installing dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
	base-devel          \
	git                 \
	fontconfig          \
	freetype2           \
	libx11              \
	glib2               \
	expat               \
	libpng              \
	libxcb              \
	libffi              \
	pcre2               \
	util-linux          \
	libxau              \
	libxdmcp            \
	python-poetry       \
	pipewire-audio      \
	pulseaudio-alsa     \
	qt6-wayland         \
	vulkan-mesa-layers  \
	wget                \
	xorg-server-xvfb    \
	zsync

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
wget --retry-connrefused --tries=30 "$EXTRA_PACKAGES" -O ./get-debloated-pkgs.sh
chmod +x ./get-debloated-pkgs.sh
./get-debloated-pkgs.sh --add-common --prefer-nano intel-media-driver-mini ffmpeg-mini qt6-base-mini opus-mini
