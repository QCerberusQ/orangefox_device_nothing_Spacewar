#
# Device makefile for Nothing Phone (1) - Spacewar
# Unified OrangeFox (A13/A14)
#

LOCAL_PATH := device/nothing/Spacewar

# Virtual A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

PRODUCT_USE_DYNAMIC_PARTITIONS := true
ENABLE_VIRTUAL_AB := true
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

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Boot control (recovery)
PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-impl-qti.recovery \
    bootctrl.lahaina.recovery

PRODUCT_PACKAGES_DEBUG += \
    bootctl

# Decryption
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Vibrator (optional but recommended)
PRODUCT_PACKAGES += \
    vendor.qti.hardware.vibrator.service

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/qcom-caf/bootctrl

# Crypto flags
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
BOARD_USES_METADATA_PARTITION := true

# VINTF
PRODUCT_ENFORCE_VINTF_MANIFEST := true
