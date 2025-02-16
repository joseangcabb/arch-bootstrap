#!/bin/bash

source "${CHROOT_SCRIPTS_DIR}/${USER_SETTINGS}"

sed -i "s/^#en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen
locale-gen

echo "LANG=en_US.UTF-8" > /etc/locale.conf
