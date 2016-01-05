#!/bin/bash
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ..
make clean
make
cd EDISON/bcm43340
make clean
KERNEL_SRC=../.. make
mkdir -p ../extra
cp bcm4334x.ko ../extra

