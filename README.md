# Intel Edison for Yocto 3.10.65
*Intel's Edison kernel patch for Yocto 3.10.17, applied to Yocto 3.10.65.*

Intel's Edison device is pretty spiffy, but the provided kernel is absolutely ancient.
The Intel patches to Yocto are intended to be applied to version
3.10.17 of the kernel, which was released before the age of dinosaurs.

Unfortunately, the Edison won't boot a kernel without Intel's patches.

This repo contains a Yocto 3.10 kernel, version 3.10.65, with the Intel Edison
patch applied.  Additional fixes described below have also been applied.

## Patches Applied

* Intel Edison kernel patch
* bluetooth rfcomm tty kernel panic patch



