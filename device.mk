#
# device.mk – Nothing Phone (1) / Spacewar
# FINAL / GOLD – Vendor_boot-as-Recovery (OrangeFox)
#

LOCAL_PATH := device/nothing/Spacewar

# -----------------------------------------------------------------------------
# Base configuration
# -----------------------------------------------------------------------------
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# -----------------------------------------------------------------------------
# Vendor_boot recovery (NO launch_with_vendor_ramdisk)
# -----------------------------------------------------------------------------
# Recovery lives in vendor_boot ONLY – do NOT hook into ROM boot flow

PRODUCT_PACKAGES += \
    linker.vendor_ramdisk \
    e2fsck.vendor_ramdisk \
    fsck.vendor_ramdisk \
    tune2fs.vendor_ramdisk \
    resize2fs.vendor_ramdisk

# -----------------------------------------------------------------------------
# API / Dynamic partitions
# -----------------------------------------------------------------------------
PRODUCT_SHIPPING_API_LEVEL := 31
PRODUCT_USE_DYNAMIC_PARTITIONS := true
TW_FRAMERATE := 120

# -----------------------------------------------------------------------------
# A/B OTA
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
    vendor_dlkm \
    vendor_boot

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

# -----------------------------------------------------------------------------
# Boot control (CRITICAL – fixes recovery loop & slot issues)
# -----------------------------------------------------------------------------
PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-impl-qti.recovery \
    android.hardware.boot@1.1-service \
    libgptutils.nothing \
    bootctl \
    otapreopt_script

PRODUCT_PACKAGES_DEBUG += \
    bootctl

# -----------------------------------------------------------------------------
# Crypto / Decryption (Recovery only)
# -----------------------------------------------------------------------------
PRODUCT_PACKAGES += \
    android.system.keystore2 \
    qcom_decrypt \
    qcom_decrypt_fbe

# -----------------------------------------------------------------------------
# Recovery display / UI libraries
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
# Soong namespaces
# -----------------------------------------------------------------------------
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/qcom-caf/bootctrl \
    vendor/qcom/opensource/commonsys-intf/display

# -----------------------------------------------------------------------------
# Recovery scripts
# -----------------------------------------------------------------------------
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/system/bin/unified-script.sh:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/unified-script.sh \
    $(LOCAL_PATH)/recovery/root/system/bin/runatboot.sh:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/runatboot.sh

# -----------------------------------------------------------------------------
# Properties
# -----------------------------------------------------------------------------
PRODUCT_PROPERTY_OVERRIDES += \
    ro.virtual_ab.skip_snapshot_creation=true \
    ro.virtual_ab.skip_verify_source_hash=true

# -----------------------------------------------------------------------------
# OrangeFox / TWRP options
# -----------------------------------------------------------------------------
TW_CUSTOM_CPU_TEMP_PATH := "/sys/devices/virtual/thermal/thermal_zone50/temp"
TW_CUSTOM_BATTERY_PATH := "/sys/class/power_supply/battery"
TW_SUPPORT_INPUT_AIDL_HAPTICS_FIX_OFF := true
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
