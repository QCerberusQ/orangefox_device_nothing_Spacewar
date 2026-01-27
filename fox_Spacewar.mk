#
# fox_Spacewar.mk - OrangeFox Configuration for Nothing Phone (1)
#

# -----------------------------------------------------------------------------
# Screen Settings (Nothing Phone 1 - Punch Hole)
# -----------------------------------------------------------------------------
OF_SCREEN_H := 2400
OF_STATUS_H := 115
OF_STATUS_INDENT_LEFT := 48
OF_STATUS_INDENT_RIGHT := 48
OF_HIDE_NOTCH := 1
OF_CLOCK_POS := 1

# -----------------------------------------------------------------------------
# LED & Haptics
# -----------------------------------------------------------------------------
OF_USE_GREEN_LED := 0
# Titreşim desteği (BoardConfig'de servisi açmıştık, burada da izin verelim)
OF_ENABLE_HAPTICS := 1

# -----------------------------------------------------------------------------
# Backup Settings
# -----------------------------------------------------------------------------
# Boot ve Data en sık yedeklenenlerdir, listeye bunları ekliyoruz
OF_QUICK_BACKUP_LIST := /boot;/data;

# -----------------------------------------------------------------------------
# System & Partition Tools
# -----------------------------------------------------------------------------
OF_ENABLE_LPTOOLS := 1
OF_ENABLE_ALL_PARTITION_TOOLS := 1
OF_USE_DMCTL := 1

# -----------------------------------------------------------------------------
# Data Format & Encryption
# -----------------------------------------------------------------------------
# F2FS formatlarken sdcard hatasını önler
OF_UNBIND_SDCARD_F2FS := 1

# Format Data sonrası şifreleme meta verisini temizler (Bootloop önler)
OF_WIPE_METADATA_AFTER_DATAFORMAT := 1

# Format sonrası MTP sorunlarını çözer
OF_BIND_MOUNT_SDCARD_ON_FORMAT := 1

# -----------------------------------------------------------------------------
# UNIFIED LOGIC (Alioth Mantığı Burada da Geçerli)
# -----------------------------------------------------------------------------
ifeq ($(FOX_VENDOR_BOOT_RECOVERY),1)
   # Header v4 (Vendor Boot) Modu:
   # OrangeFox yüklenirken tüm Ramdisk'i vendor_boot içine yeniden paketler.
   # Bu, Unified yapı için KRİTİKTİR.
   OF_RECOVERY_AB_FULL_REFLASH_RAMDISK := 1
   OF_SLOT_BASED_INSTALLER := 1
else
   # Header v3 (Boot Image) Modu:
   # Klasik sıkıştırma kullanır.
   OF_USE_LZ4_COMPRESSION := 1
endif

# -----------------------------------------------------------------------------
# Extras
# -----------------------------------------------------------------------------
# Gelişmiş menü seçenekleri
OF_OPTIONS_LIST_NUM := 9
OF_ENABLE_FRP_ADDON := 1
