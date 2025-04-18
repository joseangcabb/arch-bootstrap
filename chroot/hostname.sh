echo ${HOSTNAME} > /etc/hostname

cat > /etc/hosts <<EOL
127.0.0.1	localhost
::1		localhost
EOL
