#
# BoardConfig.mk – Nothing Phone (1) / Spacewar
# Fixed for Header v3 Compliance (Ramdisk in Boot)
#

# -----------------------------------------------------------------------------
# Build sanity
# -----------------------------------------------------------------------------
ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_ARTIFACT_PATH_REQUIREMENTS := true
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

DEVICE_PATH := device/nothing/Spacewar

# -----------------------------------------------------------------------------
# Architecture
# -----------------------------------------------------------------------------
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a76

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_VARIANT := cortex-a76

TARGET_SUPPORTS_64_BIT_APPS := true
TARGET_IS_64_BIT := true

# -----------------------------------------------------------------------------
# Bootloader & Kernel (Header v3 Config)
# -----------------------------------------------------------------------------
TARGET_BOARD_PLATFORM := lahaina
BOARD_USES_QCOM_HARDWARE := true

# Header Version 3 (Magisk ile doğrulandı)
BOARD_BOOT_HEADER_VERSION := 3
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

# Sayfa Boyutu
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_IMAGE_NAME := Image

# CMDLINE (Magisk ile doğrulandı)
BOARD_KERNEL_CMDLINE := androidboot.hardware=qcom androidboot.memcg=1 lpm_levels.sleep_disabled=1 service_locator.enable=1 androidboot.usbcontroller=a600000.dwc3 swiotlb=0 loop.max_part=7 cgroup.memory=nokmem,nosocket pcie_ports=compat iptable_raw.raw_before_defrag=1 ip6table_raw.raw_before_defrag=1

# -----------------------------------------------------------------------------
# Kernel (Prebuilt + Source Headers)
# -----------------------------------------------------------------------------
KERNEL_PATH := $(DEVICE_PATH)/prebuilt
TARGET_PREBUILT_KERNEL := $(KERNEL_PATH)/kernel

# Decryption Header'ları için kaynak kod
TARGET_KERNEL_SOURCE := kernel/nothing/sm7325
TARGET_KERNEL_CONFIG := vendor/lahaina-qgki_defconfig

# -----------------------------------------------------------------------------
# DTB / DTBO Configuration
# -----------------------------------------------------------------------------
# Header 3 olduğu için DTB boot içine de eklenebilir, 
# ancak vendor_boot içinde DTB'yi tutmak için aşağıdaki ayar kalabilir.
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_SEPARATED_DTBO := true

# DTBO Dosyası
BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PATH)/dtbo.img

# DTB Klasörü (Spacewar.dtb)
BOARD_PREBUILT_DTBIMAGE_DIR := $(KERNEL_PATH)/dtbs

# -----------------------------------------------------------------------------
# Partitions & Filesystems
# -----------------------------------------------------------------------------
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
# Header v3'te ramdisk boot.img içindedir, bu yüzden boot partition boyutu önemlidir.

BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

# Vendor Tanımları
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Vendor Boot (Sadece DTB ve Modüller için kalır)
TARGET_COPY_OUT_VENDOR_BOOT := vendor_boot
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296

# Ramdisk Sıkıştırma
BOARD_RAMDISK_USE_LZ4 := true

# -----------------------------------------------------------------------------
# Recovery (Header v3: Recovery as Boot)
# -----------------------------------------------------------------------------
# DÜZELTME: Header 3 olduğu için Ramdisk BOOT.IMG içindedir.
BOARD_USES_RECOVERY_AS_BOOT := true

# HATA VEREN KOMUTLAR SİLİNDİ:
# BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true  <-- SİLİNDİ
# BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true   <-- SİLİNDİ
# VENDOR_BOOT_HAS_RECOVERY_RAMDISK := true               <-- SİLİNDİ

# -----------------------------------------------------------------------------
# Recovery UI & Crypto
# -----------------------------------------------------------------------------
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_USES_METADATA_PARTITION := true

TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
TW_USE_FSCRYPT_POLICY := 1

TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_INCLUDE_NTFS_3G := true
TW_USE_TOOLBOX := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_BRIGHTNESS_PATH :=
TW_NO_SCREEN_BLANK := true

# -----------------------------------------------------------------------------
# AVB
# -----------------------------------------------------------------------------
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_VBMETA_SYSTEM := system system_ext product
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1
