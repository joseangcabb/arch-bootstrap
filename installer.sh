#!/bin/bash

source ./config.sh || {
  echo "Error: Could not load ./config.sh"
  exit 1
}

source ./colors.sh || {
  echo "Error: Could not load ./config.sh"
  exit 1
}

echo -e "${YELLOW}ARCH BOOTSTRAP${NC}"

main() {
  bash "${SCRIPTS}/settings.sh"
  bash "${SCRIPTS}/disk.sh"
  bash "${SCRIPTS}/generate_installer.sh"

  # Installation within the chroot context 
  arch-chroot /mnt /bin/bash -c "bash ${INSTALLATION_FILE}"

  # Remove temporary installation files
  rm "/tmp/${SETTINGS_FILE}"
  rm "/mnt/${INSTALLATION_FILE}"

  # Unmount all partitions before rebooting
  umount -R /mnt
  reboot
}
  
main
