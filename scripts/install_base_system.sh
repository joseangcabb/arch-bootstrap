#!/bin/bash

echo -e "${MAGENTA}INSTALL BASE SYSTEM${NC}"

echo -e "${GREEN}>>> Installing base packages...${NC}"
# Install base packages including development tools and firmware 
pacstrap /mnt base base-devel linux linux-firmware  

echo -e "${GREEN}>>> Generating /etc/fstab...${NC}"
# The 'genfstab' generates the /etc/fstab file, which defines how partitions should be mounted
# The -U option ensures that UUIDs are used instead of device names (e.g., /dev/sda1),
# making the system more stable against disk order changes.
genfstab -U /mnt >> /mnt/etc/fstab
