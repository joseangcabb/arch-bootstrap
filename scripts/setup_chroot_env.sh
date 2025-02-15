#!/bin/bash

# Install base system
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

# Copy setup scripts into the chroot environment
mkdir -p "/mnt${CHROOT_SCRIPTS_DIR}"
cp -rv "${HOST_SCRIPTS_DIR}/chroot" "/mnt${CHROOT_SETUP_DIR}"
cp -v "${USER_SETTINGS}" "/mnt${CHROOT_SETUP_DIR}"
