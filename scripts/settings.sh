#!/bin/bash

source ./functions.sh || {
  echo "Error: Could not load ./functions.sh"
  exit 1
}

echo -e "${MAGENTA}SETTINGS${NC}"

echo -e "${GREEN}>>> System settings...${NC}"
read -rp "Hostname: " hostname 
read -rp "Timezone (e.g. America/New_York): " timezone
read -rp "Language (e.g. en_US.UTF-8): " lang

echo -e "${GREEN}>>> Partition sizes...${NC}"
read -rp "Size for EFI (e.g. 500M): " efi_size
read -rp "Size for Root (e.g. 50G): " root_size
read -rp "Size for Swap(e.g. 8G): " swap_size

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
