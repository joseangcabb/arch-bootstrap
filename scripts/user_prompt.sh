#!/bin/bash

source ./config.sh

read -p "Size for EFI (default 500M): " efi_size
efi_size=${efi_size:-500M}

read -p "Size for Root (default 50G): " root_size
root_size=${root_size:-50G}

read -p "Size for Swap (default 8G): " swap_size
swap_size=${swap_size:-8G}

echo "EFI_SIZE='${efi_size}'" > "${USER_SETTINGS}"
echo "ROOT_SIZE='${root_size}'" >> "${USER_SETTINGS}"
echo "SWAP_SIZE='${swap_size}'" >> "${USER_SETTINGS}"

