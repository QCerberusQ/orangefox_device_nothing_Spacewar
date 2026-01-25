#
# device.mk – Nothing Phone (1) / Spacewar
# OrangeFox Recovery – boot.img as recovery (STABLE)
#

LOCAL_PATH := device/nothing/Spacewar

# -----------------------------------------------------------------------------
# Base
# -----------------------------------------------------------------------------
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# -----------------------------------------------------------------------------
# Kernel (SOURCE – REQUIRED)
# -----------------------------------------------------------------------------
include kernel/nothing/sm7325/Android.mk

# -----------------------------------------------------------------------------
# A/B postinstall
# -----------------------------------------------------------------------------
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    otapreopt_script

# -----------------------------------------------------------------------------
# Boot control HAL
# -----------------------------------------------------------------------------
PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-impl-qti.recovery \
    bootctrl.lahaina.recovery

PRODUCT_PACKAGES_DEBUG += \
    bootctl

# -----------------------------------------------------------------------------
# Dynamic partitions
# -----------------------------------------------------------------------------
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# -----------------------------------------------------------------------------
# Fastbootd
# -----------------------------------------------------------------------------
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# -----------------------------------------------------------------------------
# Soong namespaces
# -----------------------------------------------------------------------------
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/qcom-caf/bootctrl \
    vendor/qcom/opensource/commonsys-intf/display

# -----------------------------------------------------------------------------
# Update engine
# -----------------------------------------------------------------------------
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# -----------------------------------------------------------------------------
# TWRP / OrangeFox UI & tools
