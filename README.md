### flashing orangefox

- download `boot.img` from [lineage os build](https://download.lineageos.org/devices/Spacewar/builds)
- download `orangefox_nothing_spacewar.img` from [releases](https://github.com/pocketblue/recovery/releases)

```shell
fastboot --set-active=a
fastboot flash boot_a boot.img
fastboot flash vendor_boot_a orangefox-nothing-spacewar.img
fastboot reboot recovery
