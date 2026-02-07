#
# device.mk – Nothing Phone (1) / Spacewar
# FINAL STABLE – Pure & Safe Edition
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
# Vendor Boot (MANDATORY FOR V4)
# -----------------------------------------------------------------------------
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

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
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# -----------------------------------------------------------------------------
# Boot Control (NP1 Custom)
# -----------------------------------------------------------------------------
# Boot kontrolü için bunlar ŞART, ama gereksiz update_engine servislerini sildik.
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot-service.qti \
    android.hardware.boot-service.qti.recovery \

# -----------------------------------------------------------------------------
# Fastbootd
# -----------------------------------------------------------------------------
# Mock (Taklit) HAL silindi. Sadece binary kalsın.
PRODUCT_PACKAGES += \
    fastbootd

# -----------------------------------------------------------------------------
# Crypto / Decryption
# -----------------------------------------------------------------------------
PRODUCT_PACKAGES += \
    android.system.keystore2 \
    qcom_decrypt \
    qcom_decrypt_fbe

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
# Health HAL
# -----------------------------------------------------------------------------
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service \
    libhealthd.$(PRODUCT_PLATFORM)

# -----------------------------------------------------------------------------
# Soong Namespaces
# -----------------------------------------------------------------------------
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    vendor/qcom/opensource/commonsys-intf/display

PRODUCT_ENFORCE_VINTF_MANIFEST := true

# -----------------------------------------------------------------------------
# Recovery Files
# -----------------------------------------------------------------------------
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/system/bin/unified-script.sh:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/unified-script.sh \
    $(LOCAL_PATH)/recovery/root/system/bin/runatboot.sh:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/runatboot.sh

PRODUCT_PROPERTY_OVERRIDES += \
    ro.virtual_ab.skip_snapshot_creation=true \
    ro.virtual_ab.skip_verify_source_hash=true

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/system/bin/wrappedkey-fix.sh:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/wrappedkey-fix.sh

# -----------------------------------------------------------------------------
# OrangeFox / TWRP Options
# -----------------------------------------------------------------------------

TW_CUSTOM_CPU_TEMP_PATH := "/sys/devices/virtual/thermal/thermal_zone50/temp"
TW_CUSTOM_BATTERY_PATH := "/sys/class/power_supply/battery"
TW_SUPPORT_INPUT_AIDL_HAPTICS_FIX_OFF := true
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
