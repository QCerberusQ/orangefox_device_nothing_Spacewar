#ifndef __RECOVERY_UFS_BSG_H__
#define __RECOVERY_UFS_BSG_H__

/*
 * Nothing Phone 1 (Spacewar)
 * Boot HAL 1.2 Uyumlu - Alioth Tabanlı Header
 */

#include <linux/types.h>

// Artık tanımları bu dosyalardan çekiyoruz (Temiz Yöntem)
#include "ufs.h"
#include "ioctl.h"

// --- Makrolar (Bunları silmemeliydim, geri ekledim) ---
#define BE_32(b0, b1, b2, b3) \
       ((b3 << 24) | (b2 << 16) | (b1 << 8) | b0)

#define DWORD(b0, b1, b2, b3) \
       ((b3 << 24) | (b2 << 16) | (b1 << 8) | b0)

#define FNAME_SZ 64

// --- Değişkenler ---
// Bu değişken Nothing kodlarında kullanılıyor olabilir
extern int fd_ufs_bsg;

// Nothing Phone 1 yolu
static char ufs_bsg_dev[FNAME_SZ] = "/dev/ufs-bsg";

// Fonksiyon Tanımı
int32_t set_ufs_lun(uint8_t lun_id);

#endif /* __RECOVERY_UFS_BSG_H__ */