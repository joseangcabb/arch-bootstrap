#!/bin/bash

source "${CHROOT_SCRIPTS_DIR}/${INSTALL_SETTINGS_FILE}"

echo "root:${ROOT_PASSWORD}" | chpasswd

useradd -m -G wheel ${USER_NAME}
echo "${USER_NAME}:${USER_PASSWORD}" | chpasswd

echo "%wheel ALL=(ALL) ALL" | EDITOR="tee -a" visudo > /dev/null
if [ $? -eq 0 ]; then
  echo "Successfully updated /etc/sudoers. The wheel group now has sudo access."
else
  echo "Error: Failed to update /etc/sudoers."
  exit 1
fi
