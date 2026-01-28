#
# device.mk – Nothing Phone (1) / Spacewar
# PURE VENDOR BOOT EDITION (Merged with Working Config)
#

LOCAL_PATH := device/nothing/Spacewar

# -----------------------------------------------------------------------------
# Base Configuration
# -----------------------------------------------------------------------------
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# -----------------------------------------------------------------------------
# VENDOR BOOT CONFIGURATION (MANDATORY FOR V4)
# -----------------------------------------------------------------------------
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# Vendor Ramdisk Araçları
PRODUCT_PACKAGES += \
    linker.vendor_ramdisk \
    e2fsck.vendor_ramdisk \
    fsck.vendor_ramdisk \
    tune2fs.vendor_ramdisk \
    resize2fs.vendor_ramdisk

# -----------------------------------------------------------------------------
# API & Dynamic Partitions
# -----------------------------------------------------------------------------
PRODUCT_SHIPPING_API_LEVEL := 31
PRODUCT_USE_DYNAMIC_PARTITIONS := true
TW_FRAMERATE := 120

# -----------------------------------------------------------------------------
# A/B Partitions & Postinstall (Eski Dosyadan Eklendi)
# -----------------------------------------------------------------------------
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    system \
    system_ext \
    product \
    vendor \
    vendor_boot \
    odm \
    vbmeta \
    vbmeta_system

# Postinstall Config (Eskisinde vardı, ekledik)
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# -----------------------------------------------------------------------------
# Boot Control (Custom NP1 Implementation)
# -----------------------------------------------------------------------------
# Not: Eski dosyada 'bootctrl.lahaina' vardı ama biz 'libgptutils.nothing' 
# ile daha gelişmiş bir yapı kurduk. Bunu koruyoruz.
PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-impl-qti.recovery \
    libgptutils.nothing \
    bootctl \
    otapreopt_script \
    update_engine \
    update_engine_sideload \
    update_verifier \
    update_engine_client \
    checkpoint_gc

PRODUCT_PACKAGES_DEBUG += \
    bootctl \
    update_engine_client

# -----------------------------------------------------------------------------
# Fastbootd
# -----------------------------------------------------------------------------
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# -----------------------------------------------------------------------------
# Crypto / Decryption
# -----------------------------------------------------------------------------
PRODUCT_PACKAGES += \
    android.system.keystore2 \
    android.hardware.gatekeeper@1.0-impl-qti \
    android.hardware.gatekeeper@1.0-service-qti \
    qcom_decrypt \
    qcom_decrypt_fbe

# -----------------------------------------------------------------------------
# Vendor DLKM Modules (Eski Dosyadan 'goodix_fp' Eklendi)
# -----------------------------------------------------------------------------
TW_LOAD_VENDOR_MODULES := "modules.load adsp_loader_dlkm.ko msm_drm.ko q6_notifier_dlkm.ko q6_pdr_dlkm.ko sensors_ssc.ko qti_battery_charger_main.ko fts_tp.ko goodix_fp.ko"

TW_LOAD_VENDOR_MODULES_EXCLUDE_GKI := true

# -----------------------------------------------------------------------------
# Recovery Libraries & Display
# -----------------------------------------------------------------------------
TARGET_RECOVERY_DEVICE_MODULES += \
    libandroidicu \
    libdisplayconfig.qti \
    libion \
    vendor.display.config@1.0 \
    vendor.display.config@2.0

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/libdisplayconfig.qti.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so

# -----------------------------------------------------------------------------
# Health HAL & Vibrator
# -----------------------------------------------------------------------------
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service \
    libhealthd.$(PRODUCT_PLATFORM) \
    vendor.qti.hardware.vibrator.service

# -----------------------------------------------------------------------------
# Soong Namespaces
# -----------------------------------------------------------------------------
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/qcom-caf/bootctrl \
    vendor/qcom/opensource/commonsys-intf/display

PRODUCT_ENFORCE_VINTF_MANIFEST := true

# -----------------------------------------------------------------------------
# Files & Scripts
# -----------------------------------------------------------------------------
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery.fstab:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/recovery.fstab \
    $(LOCAL_PATH)/recovery/root/system/bin/unified-script.sh:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/unified-script.sh \
    $(LOCAL_PATH)/recovery/root/system/bin/runatboot.sh:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/runatboot.sh

PRODUCT_PROPERTY_OVERRIDES += \
    ro.virtual_ab.skip_snapshot_creation=true \
    ro.virtual_ab.skip_verify_source_hash=true

# -----------------------------------------------------------------------------
# OrangeFox / TWRP Specifics (Eski Dosyadan Tamamlandı)
# -----------------------------------------------------------------------------
# Magisk Araçları
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_REPACKTOOLS := true

# Yer Tasarrufu
TW_EXCLUDE_APEX := true

# Batarya ve CPU Yolları (Eskisinden Alındı)
TW_CUSTOM_CPU_TEMP_PATH := "/sys/devices/virtual/thermal/thermal_zone50/temp"
TW_CUSTOM_BATTERY_PATH := "/sys/class/power_supply/battery"

# Haptics Fix (Eskisinden Alındı - Önemli Olabilir)
TW_SUPPORT_INPUT_AIDL_HAPTICS_FIX_OFF := true

# Ekran Parlaklığı (Eskisinden Alındı)
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
