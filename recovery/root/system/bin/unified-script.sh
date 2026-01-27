#!/system/bin/sh
#
# unified-script.sh for Nothing Phone (1)
# Forces correct device props to prevent ROM flashing errors
#

load_spacewar()
{
    # Cihaz Kimlikleri
    resetprop "ro.product.model" "Phone (1)"
    resetprop "ro.product.brand" "Nothing"
    resetprop "ro.product.name" "Spacewar"
    resetprop "ro.product.device" "Spacewar"
    resetprop "ro.build.product" "Spacewar"

    # Partisyon Bazlı Kimlikler (Hata 7 yememek için kritik)
    resetprop "ro.product.system.device" "Spacewar"
    resetprop "ro.product.vendor.device" "Spacewar"
    resetprop "ro.product.odm.device" "Spacewar"
    resetprop "ro.product.product.device" "Spacewar"
    resetprop "ro.product.system_ext.device" "Spacewar"
    
    # Model İsimleri
    resetprop "ro.product.system.model" "Phone (1)"
    resetprop "ro.product.vendor.model" "Phone (1)"
}

# Fonksiyonu çalıştır
load_spacewar;

exit 0
