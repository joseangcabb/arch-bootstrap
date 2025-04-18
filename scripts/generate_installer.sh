#!/bin/bash

echo -e "${MAGENTA}INSTALL SYSTEM${NC}"

echo -e "${GREEN}>>> Creating installation file...${NC}"
MODULE_FILES=(
  "timezone.sh"
  "locale.sh"
  "hostname.sh"
  "users.sh"
  "bootloader.sh"
  "services.sh"
)

{
  echo "#!/bin/bash"
  cat "/tmp/${SETTINGS_FILE}"

  for module in "${MODULE_FILES[@]}"; do
    cat "${MODULES}/${module}"
  done
} > "/mnt/${INSTALLATION_FILE}"

echo ">>> Installing base system..."
echo -e "${GREEN}>>> Installing base system...${NC}"
# Install base packages including development tools and firmware 
pacstrap /mnt base base-devel linux linux-firmware >/dev/null 2>&1
  
echo -e "${GREEN}>>> Generating /etc/fstab...${NC}"
# The 'genfstab' generates the /etc/fstab file, which defines how partitions should be mounted
# The -U option ensures that UUIDs are used instead of device names (e.g., /dev/sda1),
# making the system more stable against disk order changes.
genfstab -U /mnt >> /mnt/etc/fstab
