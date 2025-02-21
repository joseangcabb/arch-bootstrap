#!/bin/bash

echo "============================================"
echo "  Arch Linux Installation - Configuration"
echo "============================================"
echo ""

source ./functions.sh || {
  echo "Error: Could not load ./functions.sh"
  exit 1
}

DEFAULT_EFI_SIZE="500M"
DEFAULT_ROOT_SIZE="50G"
DEFAULT_SWAP_SIZE="8G"

DEFAULT_TIMEZONE="America/Lima"
DEFAULT_LANG="en_US.UTF-8"

echo "=== Partitions Settings ==="
echo "Define the size of the partitions."
echo "Use values like '500M', '50G', etc."
echo ""

read -rp "Size for EFI [${DEFAULT_EFI_SIZE}]: " efi_size
efi_size="${efi_size:-${DEFAULT_EFI_SIZE}}"

read -rp "Size for Root [${DEFAULT_ROOT_SIZE}]: " root_size
root_size="${root_size:-${DEFAULT_ROOT_SIZE}}"

read -rp "Size for Swap [${DEFAULT_SWAP_SIZE}]: " swap_size
swap_size="${swap_size:-${DEFAULT_SWAP_SIZE}}"

echo "=== Root Password ==="
echo "Define password for the root user."
echo ""

read_password "Root Password: " root_password

echo "=== User Authentication ==="
echo "Define the user name and password."
echo ""

read -rp "User name: " user_name
read_password "User Password: " user_password

echo "=== Localization ==="
echo "Define the system timezone and language."
echo ""

read -rp "Timezone [${DEFAULT_TIMEZONE}]: " timezone
timezone="${timezone:-${DEFAULT_TIMEZONE}}"

read -rp "Language [${DEFAULT_LANG}]: " lang
lang="${lang:-${DEFAULT_LANG}}"

{
    echo "EFI_SIZE='${efi_size}'"
    echo "ROOT_SIZE='${root_size}'"
    echo "SWAP_SIZE='${swap_size}'"
    echo "ROOT_PASSWORD='${root_password}'"
    echo "USER_NAME='${user_name}'"
    echo "USER_PASSWORD='${user_password}'"
    echo "TIMEZONE='${timezone}'"
    echo "LANG='${lang}'"
} > "/tmp/${USER_SETTINGS}"

echo "Configuration saved successfully!"
