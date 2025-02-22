#!/bin/bash

echo "=== Build settings file ==="
echo ""

source ./functions.sh || {
  echo "Error: Could not load ./functions.sh"
  exit 1
}

# Define default values for partitions
DEFAULT_EFI_SIZE="500M"
DEFAULT_ROOT_SIZE="50G"
DEFAULT_SWAP_SIZE="8G"

# Define default values for localization
DEFAULT_TIMEZONE="America/Lima"
DEFAULT_LANG="en_US.UTF-8"

echo "${GREEN}>>> Define the size of the partitions...${NC}"
echo "Use values like '500M', '50G', etc."

# Read sizes for partitions
read -rp "Size for EFI [${DEFAULT_EFI_SIZE}]: " efi_size
efi_size="${efi_size:-${DEFAULT_EFI_SIZE}}"

read -rp "Size for Root [${DEFAULT_ROOT_SIZE}]: " root_size
root_size="${root_size:-${DEFAULT_ROOT_SIZE}}"

read -rp "Size for Swap [${DEFAULT_SWAP_SIZE}]: " swap_size
swap_size="${swap_size:-${DEFAULT_SWAP_SIZE}}"

echo ">>> Define the password for the root user..."

# Read root password
read_password "Root Password: " root_password

echo ">>> Define the user name and password..."

# Read user name and password
read -rp "User name: " user_name
read_password "User Password: " user_password

echo ">>> Define the system timezone and language..."

# Read timezone and language
read -rp "Timezone [${DEFAULT_TIMEZONE}]: " timezone
timezone="${timezone:-${DEFAULT_TIMEZONE}}"

read -rp "Language [${DEFAULT_LANG}]: " lang
lang="${lang:-${DEFAULT_LANG}}"

echo ">>> Saving settings file..."

# Save the settings to a temporary file
{
    echo "EFI_SIZE='${efi_size}'"
    echo "ROOT_SIZE='${root_size}'"
    echo "SWAP_SIZE='${swap_size}'"
    echo "ROOT_PASSWORD='${root_password}'"
    echo "USER_NAME='${user_name}'"
    echo "USER_PASSWORD='${user_password}'"
    echo "TIMEZONE='${timezone}'"
    echo "LANG='${lang}'"
} > "/tmp/${INSTALL_SETTINGS_FILE}"
