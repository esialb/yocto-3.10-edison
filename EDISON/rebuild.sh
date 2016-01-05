#!/bin/bash

if [ ! -f ./EDISON/rebuild.sh ]; then
  echo "please run from the root of a Yocto kernel repo"
  exit 1
fi

RELEASE=$(cat include/generated/utsrelease.h | awk '{print $3}' | perl -p -e 's/^"(.*)"$/$1/')

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ..
make clean
make
cd EDISON/bcm43340
make clean
KERNEL_SRC=../.. make

