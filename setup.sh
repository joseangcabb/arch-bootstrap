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
  "bash ./scripts/disk.sh '$efi_size' '$root_size' '$swap_size'" \
  "Disk partition"
