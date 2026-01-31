### Flashing orangefox

- download `OrangeFox-R11.3_VendorBoot-Beta-Spacewar_` from [releases](https://github.com/""/recovery/releases)

```shell
fastboot --set-active=a
fastboot flash vendor_boot orangefox-nothing-spacewar.img
fastboot reboot recovery
