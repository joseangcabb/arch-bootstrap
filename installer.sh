#!/bin/bash

echo "==============================="
echo "=== Arch Linux Installation ==="
echo "==============================="
echo ""

source ./config.sh || {
  echo "Error: Could not load ./config.sh"
  exit 1
}

source ./functions.sh || {
  echo "Error: Could not load ./functions.sh"
  exit 1
}

main() {
  # Build settings file to be used in the installation
  bash "${HOST_SCRIPTS_DIR}/build_settings.sh"

  # Prepare disk partitions and file systems
  bash "${HOST_SCRIPTS_DIR}/prepare_disk.sh"

  # Copy scripts into the chroot environment
  bash "${HOST_SCRIPTS_DIR}/setup_chroot_env.sh"

  # Run scripts in chroot context 
  arch-chroot /mnt /bin/bash -c "bash ${CHROOT_SCRIPTS_DIR}/timezone.sh"
  arch-chroot /mnt /bin/bash -c "bash ${CHROOT_SCRIPTS_DIR}/locale.sh"
  arch-chroot /mnt /bin/bash -c "bash ${CHROOT_SCRIPTS_DIR}/hostname.sh"
  arch-chroot /mnt /bin/bash -c "bash ${CHROOT_SCRIPTS_DIR}/users.sh"
  arch-chroot /mnt /bin/bash -c "bash ${CHROOT_SCRIPTS_DIR}/bootloader.sh"
  arch-chroot /mnt /bin/bash -c "bash ${CHROOT_SCRIPTS_DIR}/services.sh"

  # Remove chroot scripts after installation to clean up
  rm -rf "/mnt/${CHROOT_SCRIPTS_DIR}"

  # Unmount all partitions before rebooting
  umount -R /mnt
  reboot

}
  
main
