#
# SPDX-License-Identifier: Apache-2.0
#
# OrangeFox Recovery Project
# Product makefile for Nothing Phone (1)
# Codename: Spacewar
# Recovery type: vendor_boot-as-recovery (v2, alioth model)
#

# -----------------------------------------------------------------------------
# Release / device naming (alioth style)
# -----------------------------------------------------------------------------
PRODUCT_RELEASE_NAME := Spacewar
DEVICE_PATH := device/nothing/$(PRODUCT_RELEASE_NAME)

# -----------------------------------------------------------------------------
# Inherit device configuration
# -----------------------------------------------------------------------------
$(call inherit-product, $(DEVICE_PATH)/device.mk)

# -----------------------------------------------------------------------------
# Optional OrangeFox device-specific config (future-proof)
# -----------------------------------------------------------------------------
$(call inherit-product-if-exists, $(DEVICE_PATH)/fox_spacewar.mk)

# -----------------------------------------------------------------------------
# Inherit common TWRP / OrangeFox configuration
# -----------------------------------------------------------------------------
$(call inherit-product, vendor/twrp/config/common.mk)

# -----------------------------------------------------------------------------
# Build sanity
# -----------------------------------------------------------------------------
BUILD_BROKEN_ARTIFACT_PATH_REQUIREMENTS := true

# -----------------------------------------------------------------------------
# Device identifiers (MUST be last)
# -----------------------------------------------------------------------------
PRODUCT_NAME := twrp_$(PRODUCT_RELEASE_NAME)
PRODUCT_DEVICE := $(PRODUCT_RELEASE_NAME)
PRODUCT_BRAND := Nothing
PRODUCT_MODEL := A063
PRODUCT_MANUFACTURER := Nothing
