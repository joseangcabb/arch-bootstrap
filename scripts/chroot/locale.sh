#!/bin/bash

source "${CHROOT_SCRIPTS_DIR}/${INSTALL_SETTINGS}"

sed -i "s/^#${LANG}/${LANG}/" /etc/locale.gen
locale-gen

echo "LANG=${LANG}" > /etc/locale.conf
