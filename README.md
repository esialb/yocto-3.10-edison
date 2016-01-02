# Yocto Linux 3.10.65 Patched for Intel Edison
*Intel's Edison kernel patch for Yocto 3.10.17, applied to Yocto 3.10.65.*

Intel's Edison device is pretty spiffy, but the provided kernel is absolutely ancient.
The Intel patches to Yocto are intended to be applied to version
3.10.17 of the kernel, which was released before the age of dinosaurs.

Unfortunately, the Edison won't boot a kernel without Intel's patches.

This repo contains a Yocto 3.10 kernel, version 3.10.65, with the Intel Edison
patch applied.  Additional fixes described below have also been applied.

Intel Edison kernel patch taken from: *edison-GPL_LGPL-sources-ww18-15/i586-poky-linux/linux-yocto-3.10.17+gitAUTOINC+6ad20f049a_c03195ed6e-r0/upstream_to_edison.patch*

Intel Edison default kernel config taken from: *edison-GPL_LGPL-sources-ww18-15/i586-poky-linux/linux-yocto-3.10.17+gitAUTOINC+6ad20f049a_c03195ed6e-r0/defconfig*


## Patches Applied
* Intel Edison kernel patch
* [bluetooth rfcomm tty kernel panic patch](commit/6200568c0b18ffe0655a59ef4e52af8ba218a9ae)

## Goodies
See the [EDISON](EDISON/) folder.
* `default-edison-dotconfig` default kernel .config file provided with ww18-15
* `dfu-image-install.sh` shell script which will install a newly built kernel in an Edison DFU `toFlash/` directory

