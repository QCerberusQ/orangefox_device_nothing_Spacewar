#
# device.mk – Nothing Phone (1) / Spacewar
# Cleaned & Optimized for Unified Build
#

LOCAL_PATH := device/nothing/Spacewar

# -----------------------------------------------------------------------------
# Base / Product Configuration
# -----------------------------------------------------------------------------
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Unified / Vendor Boot için kritik:
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# -----------------------------------------------------------------------------
# Fstab & Init Scripts (KRİTİK EKSİKTİ)
# -----------------------------------------------------------------------------
# recovery.fstab dosyasının cihaz ağacında olduğundan emin ol!
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery.fstab:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/recovery.fstab

# -----------------------------------------------------------------------------
# Dynamic Partitions
# -----------------------------------------------------------------------------
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# -----------------------------------------------------------------------------
# Boot Control & OTA
# -----------------------------------------------------------------------------
PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-impl-qti.recovery \
    bootctrl.lahaina.recovery \
    bootctl \
    otapreopt_script \
    update_engine \
    update_engine_sideload \
    update_verifier \
    update_engine_client

# -----------------------------------------------------------------------------
# Fastbootd
# -----------------------------------------------------------------------------
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# -----------------------------------------------------------------------------
# Crypto / Decryption (Android 14 Ready)
# -----------------------------------------------------------------------------
PRODUCT_PACKAGES += \
    android.system.keystore2 \
    qcom_decrypt \
    qcom_decrypt_fbe

# -----------------------------------------------------------------------------
# Vendor DLKM Modules (Touch & Display)
# -----------------------------------------------------------------------------
# Bu modüllerin cihaz ağacında "recovery/root/vendor/lib/modules" 
# veya "prebuilt/modules" içinde olduğundan emin ol.
TW_LOAD_VENDOR_MODULES := \
    modules.load \
    adsp_loader_dlkm.ko \
    msm_drm.ko \
    q6_notifier_dlkm.ko \
    q6_pdr_dlkm.ko \
    sensors_ssc.ko \
    qti_battery_charger_main.ko \
    fts_tp.ko

TW_LOAD_VENDOR_MODULES_EXCLUDE_GKI := true

# -----------------------------------------------------------------------------
# Display / libraries
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
    hardware/qcom-caf/bootctrl \
    vendor/qcom/opensource/commonsys-intf/display

# -----------------------------------------------------------------------------
# Additional Tools
# -----------------------------------------------------------------------------
PRODUCT_PACKAGES += \
    linker.vendor_ramdisk \
    e2fsck.vendor_ramdisk \
    fsck.vendor_ramdisk \
    tune2fs.vendor_ramdisk

# -----------------------------------------------------------------------------
# VINTF & Properties
# -----------------------------------------------------------------------------
PRODUCT_ENFORCE_VINTF_MANIFEST := true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.virtual_ab.skip_snapshot_creation=true \
    ro.virtual_ab.skip_verify_source_hash=true
