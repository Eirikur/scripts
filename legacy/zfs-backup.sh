#!/bin/bash



sudo zpool create backup -f \
     mirror /dev/disk/by-id/ata-ST4000VN000-1H4168_Z304N6R2 \
            /dev/disk/by-id/ata-TOSHIBA_MD04ACA400_Y764KTMLFFZD \
     mirror /dev/disk/by-id/ata-WDC_WD40EMRX-82UZ0N0_WD-WCC7K6HDYTET \
            /dev/disk/by-id/ata-WDC_WD40EZRZ-00GXCB0_WD-WCC7K4AE0HJK 
            
sudo zfs set compression=on backup
