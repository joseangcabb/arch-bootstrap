#!/bin/bash

source ./config.sh

main() {
  bash "${SCRIPTS_DIR}/user_prompt.sh"
  bash "${SCRIPTS_DIR}/prepare_disk.sh"
  bash "${SCRIPTS_DIR}/setup_chroot_env.sh"
  arch-chroot /mnt /bin/bash -c "bash ${CHROOT_SETUP_DIR}/locale.sh"

}
  
main "@"
