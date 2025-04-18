sed -i "s/^#${LANG}/${LANG}/" /etc/locale.gen
locale-gen

echo "LANG=${LANG}" > /etc/locale.conf
