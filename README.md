### Flashing orangefox

- download `OrangeFox-R11.3_VendorBoot-Beta-Spacewar_` from [releases](https://github.com/""/recovery/releases)

```shell
fastboot --set-active=a
fastboot flash vendor_boot OrangeFox-R11.3_VendorBoot-Beta-Spacewar
fastboot reboot recovery
```

⚠️ ÖNEMLİ UYARILAR VE KURULUM NOTLARI / IMPORTANT WARNINGS & INSTALLATION NOTES


🇹🇷 Türkçe (Turkish)

OrangeFox İlk Kurulumu Yapacak Kullanıcılar İçin Not
ROM Flaşlama: OrangeFox’u ilk kez kurup açtıktan sonra, cihazınızda hâlihazırda yüklü olan ROM’u cihazınıza atarak tekrar flaşlamalısınız. Bu adımı atlamanız durumunda cihazınız bootloop (başlangıç döngüsü) hatasına düşecektir. Bu hata, ROM’un orijinal vendor_boot.img dosyası flaşlanmadan düzelmez.

Veri Sıfırlama: Mevcut ROM’unuzu tekrar kurduğunuz için Format Data yapmanıza gerek yoktur.

Format Data Ne Zaman Yapılır? Bu işlem yalnızca ROM değişikliklerinde veya sistemi tamamen sıfırlamak istediğinizde gereklidir.

Kritik Uyarı: Format Data adımı her zaman OrangeFox üzerinden gerçekleştirilmelidir. Eğer ROM'un kendi recovery'si veya başka bir custom recovery üzerinden Format Data yaparsanız, OrangeFox işlevsiz hâle gelecektir.

A/B Bölüm Yapısı ve Slot Geçişleri
Slot Mantığı: Bu cihaz A/B yapısına sahip olduğu için OrangeFox üzerinden flaşladığınız ROM’lar ve beraberindeki recovery dosyaları cihazın "B" slotuna yazılır. OrangeFox ise "A" slotunda kalmaya devam eder.

Kurulum Sonrası: ROM flaşlama işlemi bittikten sonra sırasıyla Format Data > Yes yapın ve ardından Reboot to Recovery diyerek cihazı yeniden başlatın.

Recovery Seçimi: Cihaz ilk açılışta ROM’un kendi recovery ekranında başlayacaktır. Paniğe gerek yok; recovery ayarlarından Switch Slot kısmına gelip "Slot A" seçeneğini işaretleyerek cihazı tekrar recovery modunda başlatırsanız OrangeFox açılacaktır.

Sistemi Başlatma (Hayati Adım): OrangeFox açıldıktan sonra işlemlerinizi tamamlayınca sakın doğrudan "Reboot System" yapmayın.

Güvenli Çıkış: OrangeFox’tan çıkarken Reboot menüsüne gelin, en alttaki Switch Slot B seçeneğini işaretleyin ve ardından Reboot System butonuna basın. Cihazınız bu şekilde sorunsuz bir şekilde açılacaktır.


🇺🇸 İngilizce (English)


Note for First-Time OrangeFox Installation
Flashing the ROM: After installing and launching OrangeFox for the first time, you must transfer your currently installed ROM to your device and flash it again. Skipping this step will cause your device to enter a bootloop, which cannot be resolved without flashing the ROM's original vendor_boot.img file.

Data Reset: Since you are reinstalling the existing ROM, there is no need to perform Format Data.

When to Format Data? This step is only required when switching to a different ROM or if you wish to factory reset the system.

Critical Warning: The Format Data step must always be performed through OrangeFox. If you format data using the ROM's stock recovery or any other custom recovery, OrangeFox will be rendered non-functional.

A/B Partition Structure & Slot Switching
Slot Logic: Since this device uses an A/B partition scheme, ROMs and their associated recovery images flashed via OrangeFox are written to "Slot B", while OrangeFox remains hosted on "Slot A".

Post-Installation: After the ROM flash is complete, perform Format Data > Yes, then select Reboot to Recovery to restart the device.

Switching Recovery: The device will initially boot into the ROM's stock recovery. Do not worry; navigate to the recovery settings, find the Switch Slot option, select "Slot A", and reboot to recovery again to access OrangeFox.

Booting the System (Vital Step): Once you have accessed OrangeFox and finished your tasks, do not select "Reboot System" directly.

Safe Exit: To exit OrangeFox properly, navigate to the Reboot menu, select Switch Slot B at the bottom, and then tap Reboot System. This ensures your device boots into the OS without issues.


### bugs

- battery status %100
- The vibration is not working
- unknown
