#
# vendorsetup.sh – Spacewar (boot.img-as-recovery)
#

if [ -z "$BASH_SOURCE" ]; then
    echo "ERROR: bash required"
    return 1
fi

export LC_ALL="C"

# Device
export FOX_BUILD_DEVICE=Spacewar
export FOX_TARGET_DEVICES=Spacewar,spacewar
export TARGET_DEVICE_ALT=Spacewar,spacewar

# A/B
export FOX_VIRTUAL_AB_DEVICE=1
export FOX_AB_DEVICE=1

# Build info
export OF_MAINTAINER="QCerberusQ"
export FOX_BUILD_TYPE="Beta"

# UI
export OF_SCREEN_H=2400
export OF_SCREEN_W=1080
export OF_STATUS_H=100
export TW_THEME=portrait_hdpi

export TW_MAX_BRIGHTNESS=2047
export TW_DEFAULT_BRIGHTNESS=1200

# Features
export FOX_USE_NANO_EDITOR=1
export FOX_ENABLE_APP_MANAGER=1
export FOX_DELETE_AROMAFM=1

# Tools
export FOX_USE_BASH_SHELL=1
export FOX_ASH_IS_BASH=1
export FOX_USE_BUSYBOX_BINARY=1
export FOX_USE_FSCK_EROFS_BINARY=1

# Magisk
export FOX_PATCH_VBMETA_FLAG="1"
export FOX_USE_UPDATED_MAGISKBOOT=1
