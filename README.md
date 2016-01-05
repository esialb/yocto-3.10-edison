# Yocto Linux 3.10.65 Patched for Intel Edison
*Intel's Edison kernel patch for Yocto 3.10.17, applied to Yocto 3.10.65.*

Intel's Edison device is pretty spiffy, but the provided kernel is absolutely ancient.
The Intel patches to Yocto are intended to be applied to version
3.10.17 of the kernel, which was released before the age of dinosaurs.

Unfortunately, the Edison won't boot a kernel without Intel's patches.

This repo contains a Yocto 3.10 kernel, version 3.10.65, with the Intel Edison
patch applied.  Additional fixes described below have also been applied.

Intel Edison kernel patch taken from: `edison-GPL_LGPL-sources-ww18-15/i586-poky-linux/linux-yocto-3.10.17+gitAUTOINC+6ad20f049a_c03195ed6e-r0/upstream_to_edison.patch`

Intel Edison default kernel config taken from: `edison-GPL_LGPL-sources-ww18-15/i586-poky-linux/linux-yocto-3.10.17+gitAUTOINC+6ad20f049a_c03195ed6e-r0/defconfig` *(default kernel config modified to use bzip2 instead of gzip compression, since that's what u-boot wants)*

## Code Changes from Yocto Standard Base
* [Intel Edison kernel patch](https://github.com/esialb/yocto-3.10-edison/commit/135099850756dfef50f99a5bd6e3de6ca56e88ab)
* [bluetooth rfcomm tty kernel panic patch](https://github.com/esialb/yocto-3.10-edison/commit/6200568c0b18ffe0655a59ef4e52af8ba218a9ae)

## Goodies
See the [EDISON](EDISON/) folder.
* `default-edison-dotconfig` default kernel .config file provided with ww18-15
* `dfu-image-install.sh` shell script which will install a newly built kernel in an Edison DFU `toFlash/` directory
* `collect.sh` shell script will collect the kernel into a directory that can be copied over via sftp to edison
* `rebuild.sh` shell script to rebuild kenel as well as bcm4334x module

## Credits
* [Intel Edison Software Release 2.1](https://downloadcenter.intel.com/download/24910/Intel-Edison-Software-Release-2-1)
  * [edison-GPL_LGPL-sources-ww18-15.zip](https://downloadmirror.intel.com/24910/eng/edison-GPL_LGPL-sources-ww18-15.zip)
    
    Source code for Intel modifications to Yocto 3.10.  Modifications to kernel 3.10.17 are a single, giant, patch.

* [Yocto Project](https://www.yoctoproject.org/)
  * [linux-yocto-3.10](http://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto-3.10/)
    
    Yocto maints the Linux kernel from which Edison's was patched.

* [Ubuntu Bug Tracking System](https://bugs.launchpad.net/ubuntu/+source/linux)
  * [Bug #1189998 “bluetooth disconnection corrupts memory and causes...”](https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1189998)
    
    Discussion of a bluetooth rfcomm bug in 3.10.x (to be patched in 3.12) that causes kernel panics on hangup.  Includes the git commit ID of the fix applied to 3.12, which could then be cherry-picked onto 3.10.

* [Edison bcm4334x driver](https://github.com/01org/edison-bcm43340)
