#
# OrangeFox Recovery Project
# Product makefile for Nothing Phone (1)
# Codename: Spacewar
# Recovery type: vendor_boot-as-recovery
#

# Inherit from Omni / OrangeFox base
$(call inherit-product, vendor/omni/config/common.mk)

# Device-specific configuration
$(call inherit-product, device/nothing/Spacewar/device.mk)

# Device identifiers
PRODUCT_DEVICE := Spacewar
PRODUCT_NAME := omni_Spacewar
PRODUCT_BRAND := Nothing
PRODUCT_MODEL := A063
PRODUCT_MANUFACTURER := Nothing
