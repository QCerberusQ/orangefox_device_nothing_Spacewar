#
# vendorsetup.sh – Spacewar (Unified Logic / Alioth Style)
#

# -----------------------------------------------------------------------------
# Bash Safety Check
# -----------------------------------------------------------------------------
if [ -z "$BASH_SOURCE" ]; then
    echo "ERROR: This script requires bash."
    return 1
fi

export LC_ALL="C"

# -----------------------------------------------------------------------------
# Device Information
# -----------------------------------------------------------------------------
export FOX_BUILD_DEVICE="Spacewar"
export FOX_TARGET_DEVICES="Spacewar,spacewar"
export TARGET_DEVICE_ALT="Spacewar,spacewar"

# Build Info
export OF_MAINTAINER="QCerberusQ"
export FOX_BUILD_TYPE="Beta"
#export FOX_VERSION="R12.1"

# -----------------------------------------------------------------------------
# Screen Settings (Spacewar Specific)
# -----------------------------------------------------------------------------
export OF_SCREEN_H=2400
export OF_SCREEN_W=1080
export OF_STATUS_H=100
export OF_STATUS_INDENT_LEFT=48
export OF_STATUS_INDENT_RIGHT=48

# UI Theme & Brightness
export TW_THEME="portrait_hdpi"
export TW_MAX_BRIGHTNESS=2047
export TW_DEFAULT_BRIGHTNESS=1200
# Nothing Phone ledleri için:
export OF_USE_GREEN_LED=0

# -----------------------------------------------------------------------------
# Features & Tools (Alioth Style - Enhanced)
# -----------------------------------------------------------------------------
export FOX_USE_BASH_SHELL=1
export FOX_ASH_IS_BASH=1
export FOX_USE_NANO_EDITOR=1
export FOX_ENABLE_APP_MANAGER=1
export FOX_DELETE_AROMAFM=1

# Advanced Binaries (Yedekleme ve işlem hızı için önemli)
export FOX_USE_TAR_BINARY=1
export FOX_USE_SED_BINARY=1
export FOX_USE_XZ_UTILS=1
export FOX_USE_LZ4_BINARY=1
export FOX_USE_ZSTD_BINARY=1
export FOX_USE_BUSYBOX_BINARY=1
export FOX_USE_FSCK_EROFS_BINARY=1

# -----------------------------------------------------------------------------
# Magisk & Boot Patching
# -----------------------------------------------------------------------------
# Bu ayar Bootloop'u önlemek için VBMeta header'ını otomatik yamalar (Açık kalsın)
export FOX_PATCH_VBMETA_FLAG="1"
export FOX_USE_UPDATED_MAGISKBOOT=1

# -----------------------------------------------------------------------------
# A/B & Virtual AB
# -----------------------------------------------------------------------------
export FOX_VIRTUAL_AB_DEVICE=1
export FOX_AB_DEVICE=1

# -----------------------------------------------------------------------------
# CONDITIONAL BUILD LOGIC (Alioth'un Sırrı)
# -----------------------------------------------------------------------------
# Eğer BoardConfig.mk'de "FOX_VENDOR_BOOT_RECOVERY=1" dediysen;
# Bu kısım ZIP dosyasının kurulum scriptini (updater-script) ona göre ayarlar.
if [ "$FOX_VENDOR_BOOT_RECOVERY" = "1" ]; then
    # Dosya ismine "vBaR" (Vendor Boot as Recovery) ekle
    export FOX_VARIANT="Unified_v4"
    
    # OrangeFox ZIP'ine "Bunu vendor_boot bölümüne kur" emrini ver
    export FOX_INSTALLER_VENDOR_BOOT_RAMDISK_INSTALL=1
else
    # Standart Boot Modu (Header v3)
    export FOX_VARIANT="Stable"
fi
