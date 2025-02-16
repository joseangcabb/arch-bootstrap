#!/bin/bash

source ./config.sh

main() {
  bash "${HOST_SCRIPTS_DIR}/set_user_settings.sh"
  bash "${HOST_SCRIPTS_DIR}/prepare_disk.sh"
  bash "${HOST_SCRIPTS_DIR}/setup_chroot_env.sh"

  arch-chroot /mnt /bin/bash -c "bash ${CHROOT_SCRIPTS_DIR}/locale.sh"
}
  
main "@"
