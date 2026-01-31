### Flashing orangefox

- download `OrangeFox-R11.3_VendorBoot-Beta-Spacewar_` from [releases](https://github.com/""/recovery/releases)

```shell
fastboot --set-active=a
fastboot flash vendor_boot orangefox-nothing-spacewar.img
fastboot reboot recovery
```

### 🇹🇷 Türkçe (Tr)

```shell
Önemli Not: Bu cihaz A/B bölüm yapısına sahip olduğu için kurulum ve slot geçiş işlemleri sırasında aşağıdaki adımları dikkatle takip etmeniz gerekmektedir.

Slot Yapısı: OrangeFox üzerinden flaşladığınız ROM’lar ve ROM ile gelen recovery dosyaları cihazın "B" slotuna yazılır. OrangeFox ise "A" slotunda kalmaya devam eder.

Kurulum Sonrası: ROM flaşlama işlemi bittikten sonra sırasıyla Format Data > Yes yapın. Ardından Reboot to Recovery yaparak cihazı yeniden başlatın.

Recovery Geçişi: Cihaz ilk başta ROM’un kendi recovery ekranında açılacaktır. Merak etmeyin; recovery ayarlarından Switch Slot kısmına gelip "Slot A" seçeneğini işaretleyerek cihazı tekrar recovery modunda başlatırsanız OrangeFox açılacaktır.

Sistemi Başlatma (Kritik Adım): OrangeFox açıldıktan sonra işlemlerinizi tamamlayınca sakın doğrudan "Reboot System" yapmayın; aksi takdirde cihaz döngüye girer ve tekrar OrangeFox açılır.

Güvenli Çıkış: OrangeFox’tan çıkarken Reboot menüsüne gelin, alt kısımdaki seçeneklerden Switch Slot B yapın ve ardından Reboot System butonuna basın. Cihazınız bu şekilde sorunsuz açılacaktır.
```

### en English (En)

```shell
Important Note: Since this device features an A/B partition structure, you must carefully follow the steps below regarding ROM installation and slot switching.

Partition Logic: ROMs and their respective recovery images flashed via OrangeFox are written to "Slot B", while OrangeFox remains on "Slot A".

Post-Installation: After flashing the ROM, perform Format Data > Yes, then select Reboot to Recovery to restart the device.

Switching Back to OrangeFox: The device will initially boot into the ROM's stock recovery. Do not worry; navigate to the recovery settings, find the Switch Slot option, select "Slot A", and reboot to recovery again to access OrangeFox.

Booting the System (Critical Step): Once you are in OrangeFox and have completed your tasks, do not select "Reboot System" directly; otherwise, the device will boot back into OrangeFox.

Safe Exit: To exit OrangeFox properly, go to the Reboot menu, select Switch Slot B at the bottom, and then tap Reboot System. This will ensure your device boots into the OS without any issues.
```
