#
# SPDX-License-Identifier: Apache-2.0
# SPDX-License-Identifier: GPL-3.0-or-later
#

# -----------------------------------------------------------------------------
# Global / build sanity
# -----------------------------------------------------------------------------
ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_ARTIFACT_PATH_REQUIREMENTS := true

DEVICE_PATH := device/nothing/Spacewar

# -----------------------------------------------------------------------------
# Architecture
# -----------------------------------------------------------------------------
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a76

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a76

TARGET_SUPPORTS_64_BIT_APPS := true
TARGET_IS_64_BIT := true

# -----------------------------------------------------------------------------
# Assert
# -----------------------------------------------------------------------------
TARGET_OTA_ASSERT_DEVICE := Spacewar

# -----------------------------------------------------------------------------
# A/B
# -----------------------------------------------------------------------------
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    odm \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot

# -----------------------------------------------------------------------------
# Platform
# -----------------------------------------------------------------------------
BOARD_USES_QCOM_HARDWARE := true
TARGET_BOARD_PLATFORM := lahaina
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

# -----------------------------------------------------------------------------
# OrangeFox vendor_boot recovery (ALIOTH MODEL)
# -----------------------------------------------------------------------------
FOX_VENDOR_BOOT_RECOVERY := 1

BOARD_USES_RECOVERY_AS_BOOT :=
TARGET_NO_RECOVERY := true
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true

# -----------------------------------------------------------------------------
# Kernel / boot image
# -----------------------------------------------------------------------------
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_SEPARATED_DTBO := true

BOARD_BOOT_HEADER_VERSION := 4
BOARD_VENDOR_BOOTIMAGE_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

# -----------------------------------------------------------------------------
# IMPORTANT:
# Kernel cmdline is NOT used in v2 (vendor_boot handles cmdline)
# -----------------------------------------------------------------------------
BOARD_KERNEL_CMDLINE :=

# -----------------------------------------------------------------------------
# vendor_boot cmdline (alioth-style)
# -----------------------------------------------------------------------------
VENDOR_CMDLINE := console=ttyMSM0,115200n8
VENDOR_CMDLINE += androidboot.hardware=qcom
VENDOR_CMDLINE += androidboot.console=ttyMSM0
VENDOR_CMDLINE += androidboot.memcg=1
VENDOR_CMDLINE += lpm_levels.sleep_disabled=1
VENDOR_CMDLINE += msm_rtb.filter=0x237
VENDOR_CMDLINE += service_locator.enable=1
VENDOR_CMDLINE += androidboot.usbcontroller=a600000.dwc3
VENDOR_CMDLINE += swiotlb=2048
VENDOR_CMDLINE += cgroup.memory=nokmem,nosocket
VENDOR_CMDLINE += reboot=panic_warm
VENDOR_CMDLINE += androidboot.init_fatal_reboot_target=recovery

BOARD_MKBOOTIMG_ARGS += --vendor_cmdline "$(VENDOR_CMDLINE)"

# -----------------------------------------------------------------------------
# Prebuilt vendor_boot (REQUIRED – v2)
# -----------------------------------------------------------------------------
BOARD_PREBUILT_VENDOR_BOOTIMAGE := $(DEVICE_PATH)/prebuilt/vendor_boot.img

# -----------------------------------------------------------------------------
# DTB
# -----------------------------------------------------------------------------
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtbs/Spacewar.dtb
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_INCLUDE_DTB_IN_VENDOR_BOOT := true

# -----------------------------------------------------------------------------
# Kernel build (UNCHANGED – user requested same paths)
# -----------------------------------------------------------------------------
TARGET_KERNEL_SOURCE := kernel/nothing/sm7325
TARGET_KERNEL_CONFIG := vendor/lahaina-qgki_defconfig
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_CLANG_COMPILE := true

# -----------------------------------------------------------------------------
# Metadata
# -----------------------------------------------------------------------------
BOARD_USES_METADATA_PARTITION := true

# -----------------------------------------------------------------------------
# File systems / partitions
# -----------------------------------------------------------------------------
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := $(BOARD_BOOTIMAGE_PARTITION_SIZE)

BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs

TARGET_COPY_OUT_VENDOR := vendor
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

BOARD_USES_VENDOR_DLKMIMAGE := true
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs

# -----------------------------------------------------------------------------
# Recovery / display
# -----------------------------------------------------------------------------
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_RAMDISK_USE_LZ4 := true

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

# -----------------------------------------------------------------------------
# Crypto / FBE
# -----------------------------------------------------------------------------
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
TW_USE_FSCRYPT_POLICY := 1
TW_PREPARE_DATA_MEDIA_EARLY := true
PRODUCT_ENFORCE_VINTF_MANIFEST := true

# -----------------------------------------------------------------------------
# Android 14 decryption fix
# -----------------------------------------------------------------------------
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)

# -----------------------------------------------------------------------------
# OrangeFox / TWRP UI
# -----------------------------------------------------------------------------
TW_THEME := portrait_hdpi
TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 2400
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_NTFS_3G := true
TW_USE_TOOLBOX := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 1200
TWRP_INCLUDE_LOGCAT := true
TW_INCLUDE_PYTHON := true
TARGET_USES_LOGD := true
TARGET_USES_MKE2FS := true
TW_EXCLUDE_TWRPAPP := true

TW_OVERRIDE_SYSTEM_PROPS := \
    ro.build.date.utc;ro.build.product;ro.build.fingerprint=ro.system.build.fingerprint; \
    ro.build.version.incremental;ro.product.device=ro.product.system.device; \
    ro.product.model=ro.product.system.model;ro.product.name=ro.product.system.name

TW_Y_OFFSET := 20
TW_H_OFFSET := -20

# -----------------------------------------------------------------------------
# Haptics
# -----------------------------------------------------------------------------
TW_SUPPORT_INPUT_AIDL_HAPTICS := true
TW_SKIP_ADDITIONAL_FSTAB := true
