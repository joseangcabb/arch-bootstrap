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
  "bash $scripts_dir/base_system.sh" \
  "Base system"

# Setup system
mkdir -p "${host_setup_dir}"
for script in "${script_filenames[@]}"; do
  if [[ -f "$scripts_dir/$script" ]]; then
    cp -v "$scripts_dir/$script" "${host_setup_dir}/"
  else
    echo "Error!" >&2
    exit 1
  fi
done

arch-chroot /mnt <<EOF
  set -e

  pacman -Syu --noconfirm --needed

  for script in "${script_filenames[@]}"; do
    if [[ -f "$chroot_setup_dir/$script" ]]; then
      echo "${script}"
      bash "${script}"
    else
      echo "Error!" >&2
      exit 1
    fi
  done

  if [[ -d "${chroot_setup_dir}" ]]; then
    rm -rfv "${chroot_setup_dir}"
  fi
EOF
