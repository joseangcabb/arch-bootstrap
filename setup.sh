#!/bin/bash

source ./config.sh
source ./functions.sh

echo "=========================================="
echo "$script_name (Version: $script_version)"
echo "=========================================="

# Disk partitions
read -p "Size for EFI (default 500M): " efi_size
efi_size=${efi_size:-500M}

read -p "Size for Root (default 50G): " root_size
root_size=${root_size:-50G}

read -p "Size for Swap (default 8G): " swap_size
swap_size=${swap_size:-8G}

execute_with_loading \
  "bash $scripts_dir/disk.sh '$efi_size' '$root_size' '$swap_size'" \
  "Disk partition"

# Install base system
execute_with_loading \
  "bash $scripts_dir/base_system.sh"
  "Base system"

# Setup system
mkdir -p "$chroot_dir"
for script in "${script_filenames[@]}"; do
  cp "$scripts_dir/$script" "$chroot_setup_dir/"
done

arch-chroot /mnt <<EOF
  pacman -Syu --noconfirm

  for script $chroot_setup_dir/*.sh; do
    bash ./$script
  done

  rm -rf $chroot_setup_dir
EOF
