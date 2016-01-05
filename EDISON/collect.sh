#!/bin/bash

if [ ! -f ./EDISON/collect.sh ]; then
  echo "please run from the root of a Yocto kernel repo"
  exit 1
fi

RELEASE=$(cat include/generated/utsrelease.h | awk '{print $3}' | perl -p -e 's/^"(.*)"$/$1/')

FSROOT="EDISON/fsroot/${RELEASE}"

MODULES="${FSROOT}/lib/modules/${RELEASE}"

BZIMAGE="arch/x86/boot/bzImage"

echo "copying kernel modules"

[ -e "${MODULES}" ] && rm -Rf "${MODULES}"

MODCOUNT=0
for KO in `find * -name '*.ko' | egrep -v -e '^EDISON/'`; do 
  D=$(dirname "${KO}")
  mkdir -p "${MODULES}/kernel/${D}"
  cp "${KO}" "${MODULES}/kernel/${D}"
  echo -n .
  MODCOUNT=$((${MODCOUNT} + 1))
done
for KO in `find EDISON/extra -name '*.ko' | sed 's/^EDISON\/extra\///'`; do
  D=$(dirname "${KO}")
  mkdir -p "${MODULES}/extra/${D}"
  cp "EDISON/extra/${KO}" "${MODULES}/extra/${D}"
  echo -n .
  MODCOUNT=$((${MODCOUNT} + 1))
done
echo
echo "${MODCOUNT} modules copied"

echo "computing module dependencies"
cp modules.* "${MODULES}"
depmod -a -b "${FSROOT}" -F System.map "${RELEASE}"

echo "copying kernel image"

mkdir -p "${FSROOT}/lib/kernel"
mkdir -p "${FSROOT}/boot"
[ -e "${FSROOT}/boot/bzImage-${RELEASE}" ] && rm -Rf "${FSROOT}/boot/bzImage-${RELEASE}"
cp "${BZIMAGE}" "${FSROOT}/lib/kernel/bzImage-${RELEASE}"
cp "${BZIMAGE}" "${FSROOT}/boot/vmlinuz"
