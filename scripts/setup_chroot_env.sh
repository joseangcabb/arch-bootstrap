#!/bin/bash

echo "=== Setting up chroot enviroment ==="

echo ">>> Copying scripts..."

# Copy 'setup scripts' and 'install settings' into the chroot environment
mkdir -p "/mnt${CHROOT_SCRIPTS_DIR}"
cp -rv "${HOST_SCRIPTS_DIR}/chroot/." "/mnt${CHROOT_SCRIPTS_DIR}"
cp -v "/tmp/${INSTALL_SETTINGS}" "/mnt${CHROOT_SCRIPTS_DIR}"

echo ">>> Installing base system..."

# Install base packages including development tools and firmware 
pacstrap /mnt base base-devel linux linux-firmware >/dev/null 2>&1
  
echo ">>> Generating /etc/fstab..."

# The 'genfstab' generates the /etc/fstab file, which defines how partitions should be mounted
# The -U option ensures that UUIDs are used instead of device names (e.g., /dev/sda1),
# making the system more stable against disk order changes.
genfstab -U /mnt >> /mnt/etc/fstab
