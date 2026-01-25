#
# OrangeFox Recovery Project
# vendorsetup.sh for Nothing Phone (1)
# Codename: Spacewar
# Recovery type: bootimage-as-recovery
#

# -----------------------------------------------------------------------------
# Sanity
# -----------------------------------------------------------------------------
if [ -z "$BASH_SOURCE" ]; then
    echo "ERROR: This script requires bash. Run '/bin/bash' and try again."
    return 1
fi

# -----------------------------------------------------------------------------
# Locale
# -----------------------------------------------------------------------------
export LC_ALL="C"

# -----------------------------------------------------------------------------
# Device identity
# -----------------------------------------------------------------------------
export FOX_BUILD_DEVICE=Spacewar
export FOX_TARGET_DEVICES=Spacewar,spacewar
export TARGET_DEVICE_ALT=Spacewar,spacewar

# -----------------------------------------------------------------------------
# A/B
# -----------------------------------------------------------------------------
export FOX_VIRTUAL_AB_DEVICE=1
export FOX_AB_DEVICE=1

# -----------------------------------------------------------------------------
# Build info
# -----------------------------------------------------------------------------
export OF_MAINTAINER="QCerberusQ"
export FOX_BUILD_TYPE="Beta"

# -----------------------------------------------------------------------------
# Screen / UI
# -----------------------------------------------------------------------------
export OF_SCREEN_H=2400
export OF_SCREEN_W=1080
export OF_STATUS_H=100
export TW_THEME=portrait_hdpi

export TW_MAX_BRIGHTNESS=2047
export TW_DEFAULT_BRIGHTNESS=1200

export OF_STATUS_INDENT_LEFT=165
export OF_STATUS_INDENT_RIGHT=48
export OF_CLOCK_POS=0
export OF_HIDE_NOTCH=1

# -----------------------------------------------------------------------------
# Recovery features
# -----------------------------------------------------------------------------
export FOX_USE_NANO_EDITOR=1
export FOX_ENABLE_APP_MANAGER=1
export FOX_DELETE_AROMAFM=1

# -----------------------------------------------------------------------------
# Tooling
# -----------------------------------------------------------------------------
export FOX_USE_BASH_SHELL=1
export FOX_ASH_IS_BASH=1
export FOX_USE_TAR_BINARY=1
export FOX_USE_XZ_UTILS=1
export FOX_USE_LZ4_BINARY=1
export FOX_USE_ZSTD_BINARY=1
export FOX_USE_DATE_BINARY=1
export FOX_USE_BUSYBOX_BINARY=1
export FOX_USE_FSCK_EROFS_BINARY=1

# -----------------------------------------------------------------------------
# System / compatibility
# -----------------------------------------------------------------------------
export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1
export OF_NO_SPLASH_CHANGE=1
export OF_DEFAULT_KEYMASTER_VERSION=4.1

# -----------------------------------------------------------------------------
# Magisk / vbmeta
# -----------------------------------------------------------------------------
export FOX_PATCH_VBMETA_FLAG="1"
export FOX_USE_UPDATED_MAGISKBOOT=1
