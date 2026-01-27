#
# device.mk – Nothing Phone (1) / Spacewar
# Alioth Style Conditional Logic
#

LOCAL_PATH := device/nothing/Spacewar

# -----------------------------------------------------------------------------
# Base Configuration (Her iki mod için ortak)
# -----------------------------------------------------------------------------
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# API & Performance
PRODUCT_SHIPPING_API_LEVEL := 31
PRODUCT_USE_DYNAMIC_PARTITIONS := true
TW_FRAMERATE := 120

# -----------------------------------------------------------------------------
# CONDITIONAL LOGIC (Alioth'un Sırrı Burada)
# -----------------------------------------------------------------------------
# Eğer BoardConfig'de veya YAML'da FOX_VENDOR_BOOT_RECOVERY=1 dediysen burası çalışır:
ifeq ($(FOX_VENDOR_BOOT_RECOVERY),1)
    # --- HEADER v4 / UNIFIED MOD ---
    $(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
    $(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)
    
    # Vendor Ramdisk Araçları (Sadece v4 modunda gerekir)
    PRODUCT_PACKAGES += \
        linker.vendor_ramdisk \
        e2fsck.vendor_ramdisk \
        fsck.vendor_ramdisk \
        tune2fs.vendor_ramdisk \
        resize2fs.vendor_ramdisk
else
    # --- HEADER v3 / STABLE MOD ---
    # Burası boş kalabilir veya eski usul ramdisk ayarları yapılabilir.
    # Base configuration zaten boot.img için yeterlidir.
endif

# -----------------------------------------------------------------------------
# A/B Partitions (Alioth Gibi Eksiksiz Liste)
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

# -----------------------------------------------------------------------------
# Fstab Copy (Kritik)
# -----------------------------------------------------------------------------
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery.fstab:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/recovery.fstab

# -----------------------------------------------------------------------------
# Boot Control & OTA Tools
# -----------------------------------------------------------------------------
PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-impl-qti.recovery \
    bootctrl.lahaina.recovery \
    bootctl \
    otapreopt_script \
    update_engine \
    update_engine_sideload \
    update_verifier \
    update_engine_client \
    checkpoint_gc

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
# Vendor DLKM Modules (Senin Cihazına Özel)
# -----------------------------------------------------------------------------
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
    libhealthd.$(PRODUCT_PLATFORM) \
    vendor.qti.hardware.vibrator.service

# -----------------------------------------------------------------------------
# Soong & VINTF
# -----------------------------------------------------------------------------
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/qcom-caf/bootctrl \
    vendor/qcom/opensource/commonsys-intf/display

PRODUCT_ENFORCE_VINTF_MANIFEST := true

# Snapshot Hatalarını Önleme (Alioth'tan alındı)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.virtual_ab.skip_snapshot_creation=true \
    ro.virtual_ab.skip_verify_source_hash=true
