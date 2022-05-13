#!/bin/bash
ssh pi@argon.local "sudo dd if=/dev/mmcblk0 bs=1M status=progress | gzip -" | dd of="/media/eh/Internal Tank/Pi/argon-card.img.gz"
