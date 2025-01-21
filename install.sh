#!/bin/bash

bash ./scripts/disk.sh

pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt <<EOF
  pacman -Syu
  bash /tmp/timezone.sh
  bash /tmp/locale.sh
  bash /tmp/hostname.sh
  bash /tmp/network.sh
  bash /tmp/users.sh
  bash /tmp/bootloader.sh
EOF


