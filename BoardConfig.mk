#
# BoardConfig.mk – Nothing Phone (1) / Spacewar
# ALIOTH STYLE LOGIC (Conditional Build)
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
# Bootloader & Platform
# -----------------------------------------------------------------------------
TARGET_BOARD_PLATFORM := lahaina
BOARD_USES_QCOM_HARDWARE := true
TARGET_BOOTLOADER_BOARD_NAME := lahaina

# -----------------------------------------------------------------------------
# Kernel Configuration
# -----------------------------------------------------------------------------
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_IMAGE_NAME := Image

KERNEL_PATH := $(DEVICE_PATH)/prebuilt
TARGET_PREBUILT_KERNEL := $(KERNEL_PATH)/kernel
TARGET_KERNEL_SOURCE := kernel/nothing/sm7325
TARGET_KERNEL_CONFIG := vendor/lahaina-qgki_defconfig

# -----------------------------------------------------------------------------
# CMDLINE MAGIC (Alioth'un Sırrı Burada)
# -----------------------------------------------------------------------------
# 1. Komutları önce genel bir değişkene atıyoruz
MY_CMDLINE := androidboot.hardware=qcom androidboot.memcg=1 lpm_levels.sleep_disabled=1 service_locator.enable=1 androidboot.usbcontroller=a600000.dwc3 swiotlb=0 loop.max_part=7 cgroup.memory=nokmem,nosocket pcie_ports=compat iptable_raw.raw_before_defrag=1 ip6table_raw.raw_before_defrag=1

# -----------------------------------------------------------------------------
# LOGIC SWITCH (Alioth'un "Kandırmaca" Kısmı)
# -----------------------------------------------------------------------------
# Eğer Action YAML dosyasında veya terminalde "FOX_VENDOR_BOOT_RECOVERY=1" dersen burası çalışır:
ifeq ($(FOX_VENDOR_BOOT_RECOVERY),1)
    # Header v4 Modu (Vendor Boot)
    BOARD_BOOT_HEADER_VERSION := 4
    BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
    
    # Komutları vendor_cmdline içine göm (Header v4 kuralı)
    BOARD_MKBOOTIMG_ARGS += --vendor_cmdline "$(MY_CMDLINE)"
    
    # Recovery kaynaklarını vendor_boot'a taşı
    BOARD_USES_RECOVERY_AS_BOOT :=
    BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
    BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true
    BOARD_USES_GENERIC_KERNEL_IMAGE := true
    BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true
    
    # DTB Ayarları (Vendor Boot için)
    BOARD_INCLUDE_DTB_IN_VENDOR_BOOT := true
    # Boot.img içine koyma (Alioth mantığı)
    BOARD_INCLUDE_DTB_IN_BOOTIMG := 
    
    # Alioth'un koyduğu güvenlik önlemi:
    # Eğer cihazda v4 header yoksa, recovery kendini flaşlarken bozmasın diye menüyü gizler.
    ifneq ($(FOX_VENDOR_BOOT_RECOVERY_FULL_REFLASH),1)
        OF_NO_REFLASH_CURRENT_ORANGEFOX := 1
    endif

else
    # Eğer parametre YOKSA burası çalışır (Eski Usul / Header v3)
    # Bu sayede crDroid gibi v3 kernel kullanan cihazlarda bootloop olmaz.
    BOARD_BOOT_HEADER_VERSION := 3
    BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
    
    # Komutları klasik kernel_cmdline içine göm
    BOARD_KERNEL_CMDLINE := $(MY_CMDLINE)
    
    BOARD_USES_RECOVERY_AS_BOOT := true
    
    # Boot.img içine DTB koy (Eski usul)
    BOARD_INCLUDE_DTB_IN_BOOTIMG := true
endif

# -----------------------------------------------------------------------------
# DTB / DTBO (Ortak Ayarlar)
# -----------------------------------------------------------------------------
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PATH)/dtbo.img

# Force DTB Path (Senin 4MB'lık dosyan)
BOARD_PREBUILT_DTBIMAGE := $(DEVICE_PATH)/prebuilt/dtbs/Spacewar.dtb

# -----------------------------------------------------------------------------
# Partitions
# -----------------------------------------------------------------------------
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := $(BOARD_BOOTIMAGE_PARTITION_SIZE)

BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Vendor DLKM
BOARD_USES_VENDOR_DLKMIMAGE := true
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs

# Vendor Boot & Ramdisk
TARGET_COPY_OUT_VENDOR_BOOT := vendor_boot
BOARD_RAMDISK_USE_LZ4 := true

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
TW_PREPARE_DATA_MEDIA_EARLY := true
PRODUCT_ENFORCE_VINTF_MANIFEST := true

TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_INCLUDE_NTFS_3G := true
TW_USE_TOOLBOX := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_BRIGHTNESS_PATH :=
TW_NO_SCREEN_BLANK := true
TW_SUPPORT_INPUT_AIDL_HAPTICS := true

# Loglama
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
TARGET_USES_MKE2FS := true
TW_EXCLUDE_TWRPAPP := true

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
