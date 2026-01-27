#!/system/bin/sh
#
# runatboot.sh for Nothing Phone (1)
# Fixes Read/Write mounting and ensures props are set
#

set_read_write_partitions() {
  # FastbootD modundaysak dokunma
  local i=$(getprop "ro.orangefox.fastbootd");
  [ "$i" = "1" ] && return; 
  
  # Slot ekini al (_a veya _b)
  local slot=$(getprop "ro.boot.slot_suffix");
  
  # Yazılabilir olması gereken partisyonlar
  local Parts="system system_ext vendor product odm vendor_dlkm";
  
  # Hepsini döngüye al ve R/W yap
  for i in $Parts
  do
     blockdev --setrw /dev/block/mapper/$i"$slot";
  done
}

# unified-script çalışmış mı kontrol et
check_unified_script() {
  local i=$(getprop "ro.product.device");
  # Eğer cihaz adı "Spacewar" değilse (varsayılan "lahaina" vb. kaldıysa)
  if [ "$i" != "Spacewar" ] && [ "$i" != "spacewar" ]; then
	echo "I:OrangeFox: Props not set correctly. Running unified-script again" >> /tmp/recovery.log;
	/system/bin/unified-script.sh;
  fi
}

# İşlemleri başlat
set_read_write_partitions;
check_unified_script;

exit 0;
