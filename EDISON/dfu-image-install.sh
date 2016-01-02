#!/bin/bash

TOFLASH="$1"

if [ -z "${TOFLASH}" ]; then
  echo "./EDISON/dfu-image-install.sh /path/to/edison/image/toFlash"
  exit 1
fi

if [ ! -f ./EDISON/dfu-image-install.sh ]; then
  echo "please run from the root of a Yocto kernel repo"
  exit 1
fi

RELEASE=$(cat include/generated/utsrelease.h | awk '{print $3}' | sed 's/^"(.*)"$/$1/')

FSROOT_IMAGE="${TOFLASH}/edison-image-edison.ext4"
FSBOOT_IMAGE="${TOFLASH}/edison-image-edison.hddimg"

FSROOT_MOUNT="${FSROOT_IMAGE}.mnt"
FSBOOT_MOUNT="${FSBOOT_IMAGE}.mnt"

MODULES="${FSROOT_MOUNT}/lib/modules/${RELEASE}"

BZIMAGE="arch/x86/boot/bzImage"

echo "mounting filesystem images"

mkdir -p "${FSROOT_MOUNT}"
mkdir -p "${FSBOOT_MOUNT}"

mount -o loop,sync "${FSROOT_IMAGE}" "${FSROOT_MOUNT}" || exit 1
mount -o loop,sync "${FSBOOT_IMAGE}" "${FSBOOT_MOUNT}" || exit 1

echo "copying kernel modules"

[ -e "${MODULES}" ] && rm -Rf "${MODULES}"

for KO in `find . -name '*.ko'`; do 
  D=$(dirname "${KO}")
  mkdir -p "${MODULES}/kernel/${D}"
  cp "${KO}" "${MODULES}/kernel/${D}"
done

cp modules.* "${MODULES}"

echo "copying kernel image"

[ -e "${FSROOT_MOUNT}/boot/bzImage-${RELEASE}" ] && rm -Rf "${FSROOT_MOUNT}/boot/bzImage-${RELEASE}"
cp "${BZIMAGE}" "${FSROOT_MOUNT}/boot/bzImage-${RELEASE}"

[ -e "${FSROOT_MOUNT}/boot/bzImage" ] && rm -Rf "${FSROOT_MOUNT}/boot/bzImage"
ln -s "bzImage-${RELEASE}" "${FSROOT_MOUNT}/boot/bzImage"

[ -e "${FSBOOT_MOUNT}/vmlinuz" ] && rm -Rf "${FSBOOT_MOUNT}/vmlinuz"
cp "${BZIMAGE}" "${FSBOOT_MOUNT}/vmlinuz"

echo "unmounting filesystem images"

umount "${FSBOOT_MOUNT}"
umount "${FSROOT_MOUNT}"

rmdir "${FSBOOT_MOUNT}"
rmdir "${FSROOT_MOUNT}"
