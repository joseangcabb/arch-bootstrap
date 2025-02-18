#!/bin/bash

DEFAULT_EFI_SIZE="500M"
DEFAULT_ROOT_SIZE="50G"
DEFAULT_SWAP_SIZE="8G"
DEFAULT_TIMEZONE="America/Lima"
DEFAULT_LANG="en_US.UTF-8"

read_password() {
  local prompt=$1 var=$2
  while true; do
    read -rsp "${prompt}: " "$var"
    echo
    read -rsp "Confirm ${prompt}: " confirm
    echo
    if [[ "${!var}" == "$confirm" ]]; then
      break
    fi
    echo "Passwords do not match. Try again."
  done
}

read -rp "Size for EFI [${DEFAULT_EFI_SIZE}]: " efi_size
efi_size="${efi_size:-${DEFAULT_EFI_SIZE}}"

read -rp "Size for Root [${DEFAULT_ROOT_SIZE}]: " root_size
root_size="${root_size:-${DEFAULT_ROOT_SIZE}}"

read -rp "Size for Swap [${DEFAULT_SWAP_SIZE}]: " swap_size
swap_size="${swap_size:-${DEFAULT_SWAP_SIZE}}"

read_password "Root Password" root_password

read -rp "User name: " user_name
read_password "User Password" user_password

read -rp "Timezone [${DEFAULT_TIMEZONE}]: " timezone
timezone="${timezone:-${DEFAULT_TIMEZONE}}"

read -rp "Lang [${DEFAULT_LANG}]: " lang
lang="${lang:-${DEFAULT_LANG}}"

{
    echo "# Auto-generated system configuration"
    echo "EFI_SIZE='${efi_size}'"
    echo "ROOT_SIZE='${root_size}'"
    echo "SWAP_SIZE='${swap_size}'"
    echo "ROOT_PASSWORD='${root_password}'"
    echo "USER_NAME='${user_name}'"
    echo "USER_PASSWORD='${user_password}'"
    echo "TIMEZONE='${timezone}'"
    echo "LANG='${lang}'"
} > "/tmp/${USER_SETTINGS}"
