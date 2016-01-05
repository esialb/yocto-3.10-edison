#!/bin/bash

if [ ! -f ./EDISON/collect-modules.sh ]; then
  echo "please run from the root of a Yocto kernel repo"
  exit 1
fi

RELEASE=$(cat include/generated/utsrelease.h | awk '{print $3}' | perl -p -e 's/^"(.*)"$/$1/')
MODULES="EDISON/modules/${RELEASE}"

[ -e "${MODULES}" ] && rm -Rf "${MODULES}"

MODCOUNT=0
for KO in `find * -name '*.ko' | egrep -v -e '^EDISON/'`; do 
  D=$(dirname "${KO}")
  mkdir -p "${MODULES}/kernel/${D}"
  cp "${KO}" "${MODULES}/kernel/${D}"
  echo "${KO}"
  MODCOUNT=$((${MODCOUNT} + 1))
done
for KO in `find EDISON/extra -name '*.ko' | sed 's/^EDISON\/extra\///'`; do
  D=$(dirname "${KO}")
  mkdir -p "${MODULES}/extra/${D}"
  cp "EDISON/extra/${KO}" "${MODULES}/extra/${D}"
  echo "${KO}"
  MODCOUNT=$((${MODCOUNT} + 1))
done
echo
echo "${MODCOUNT} modules copied"

