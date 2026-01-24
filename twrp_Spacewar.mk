#
# OrangeFox Recovery Project
# Product makefile for Nothing Phone (1)
# Codename: Spacewar
# Recovery type: vendor_boot-as-recovery
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_minimal.mk)
# Inherit TWRP / OrangeFox base
$(call inherit-product, vendor/twrp/config/common.mk)

# Device
$(call inherit-product, device/nothing/Spacewar/device.mk)

BUILD_BROKEN_ARTIFACT_PATH_REQUIREMENTS := true

# Device identifiers
PRODUCT_DEVICE := Spacewar
PRODUCT_NAME := twrp_Spacewar
PRODUCT_BRAND := Nothing
PRODUCT_MODEL := A063
PRODUCT_MANUFACTURER := Nothing
