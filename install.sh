#!/bin/bash

bash ./tasks/disk.sh

pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

mkdir -p /mnt/tmp/tasks
cp ./tasks/{timezone.sh,locale.sh,hostname.sh,network.sh,users.sh,bootloader.sh} /mnt/tmp/tasks/

arch-chroot /mnt <<EOF
  pacman -Syu --noconfirm
  for task in /tmp/tasks/*.sh; do
    bash "\$task"
  done
EOF

rm -r /mnt/tmp/tasks


