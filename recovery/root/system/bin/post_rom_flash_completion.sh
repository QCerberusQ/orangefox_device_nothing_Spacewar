#!/system/bin/sh -x
#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2026 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#
#

LOGMSG() {
	echo "$@" >> /tmp/recovery.log;
}

# restore the backed up vendor_boot recovery image after flashing a vendor_boot ROM
restore_vboot() {
local a=$(getprop "orangefox.vendor_boot.recovery");
local b=$(getprop "tw_is_vendor_boot");
local slot=$(getprop "ro.boot.slot_suffix");
local src="/tmp/fox_vboot_backup.img";

	[ ! -s $src -o -z "$slot" ] && return;

	if [ "$a" = "true" -o "$b" = "1" ]; then
		local dest="_b";
		local root="/dev/block/bootdevice/by-name/vendor_boot";
		if [ "$slot" = "_a" ]; then
			dest=$root"_b";
		else
			dest=$root"_a";
		fi
		LOGMSG "I: Restoring OrangeFox to $dest";
		dd if="$src" of="$dest" bs=1M;
		[ "$?" = "0" ] && LOGMSG "I: Succeeded! " || LOGMSG "I: Failed :-(";
		sync;
	fi
}

#
LOGMSG "I: Running post-ROM-flash-completion script...";
restore_vboot;
exit 0;
#
