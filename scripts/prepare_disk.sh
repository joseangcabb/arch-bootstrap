#!/bin/bash

echo "==============================="
echo "=== Prepare disk partitions ==="
echo "==============================="

source "/tmp/${INSTALL_SETTINGS_FILE}"|| {
  echo "Error: Could not load /tmp/${INSTALL_SETTINGS_FILE}"
  exit 1
}

echo ">>> Cleaning up existing partitions..."

# Check if /mnt is already mounted and unmount if necessary
if mount | grep -q "/mnt"; then
  umount -R /mnt
fi

# Disable any active swap space
swapoff -a

# Wipe existing partitions
sgdisk --zap-all /dev/sda
wipefs --all /dev/sda

echo ">>> Creating partitions..."

# Create partitions
sgdisk /dev/sda --new=1:0:+${EFI_SIZE} --typecode=1:ef00 --change-name=1:EF_System
sgdisk /dev/sda --new=2:0:+${ROOT_SIZE} --typecode=2:8300 --change-name=2:Root_Filesystem
sgdisk /dev/sda --new=3:0:+${SWAP_SIZE} --typecode=3:8200 --change-name=3:Swap_Space
sgdisk /dev/sda --new=4:0: --typecode=4:8300 --change-name=4:Home_Directory

# Synchronize kernel partition table
partprobe /dev/sda

echo ">>> Formatting partitions..."

# Format partitions
mkfs.fat -F32 /dev/sda1
mkfs.ext4 -F /dev/sda2
mkfs.ext4 -F /dev/sda4

# Setup and enable swap
mkswap -f /dev/sda3
swapon /dev/sda3

echo ">>> Mounting partitions..."

# Mount partitions
mount /dev/sda2 /mnt
mkdir -p /mnt/boot/efi && mount /dev/sda1 /mnt/boot/efi
mkdir -p /mnt/home && mount /dev/sda4 /mnt/home
