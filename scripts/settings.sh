#!/bin/bash

source ./functions.sh || {
  echo "Error: Could not load ./functions.sh"
  exit 1
}

# Default partition sizes
DEFAULT_EFI_SIZE="500M"
DEFAULT_ROOT_SIZE="50G"
DEFAULT_SWAP_SIZE="8G"

# Default values for localization
DEFAULT_TIMEZONE="America/Lima"
DEFAULT_LANG="en_US.UTF-8"

echo -e "${MAGENTA}SETTINGS${NC}"

echo -e "${GREEN}>>> System settings...${NC}"
read -rp "Hostname: " hostname 

read -rp "Timezone [${DEFAULT_TIMEZONE}]: " timezone
timezone="${timezone:-${DEFAULT_TIMEZONE}}"

read -rp "Language [${DEFAULT_LANG}]: " lang
lang="${lang:-${DEFAULT_LANG}}"

echo -e "${GREEN}>>> Partition sizes (500M, 50G, etc)...${NC}"
read -rp "Size for EFI [${DEFAULT_EFI_SIZE}]: " efi_size
efi_size="${efi_size:-${DEFAULT_EFI_SIZE}}"

read -rp "Size for Root [${DEFAULT_ROOT_SIZE}]: " root_size
root_size="${root_size:-${DEFAULT_ROOT_SIZE}}"

read -rp "Size for Swap [${DEFAULT_SWAP_SIZE}]: " swap_size
swap_size="${swap_size:-${DEFAULT_SWAP_SIZE}}"

echo -e "${GREEN}>>> Root settings...${NC}"
read_password "Root Password: " root_password

echo -e "${GREEN}>>> User settings...${NC}"
read -rp "User name: " user_name
read_password "User Password: " user_password

# Generate settings file
cat > "/tmp/${SETTINGS_FILE}" <<EOF
HOSTNAME=${hostname}
TIMEZONE=${timezone}
LANG=${lang}
EFI_SIZE=${efi_size}
ROOT_SIZE=${root_size}
SWAP_SIZE=${swap_size}
ROOT_PASSWORD=${root_password}
USER_NAME=${user_name}
USER_PASSWORD=${user_password}
EOF
