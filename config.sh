#!/bin/bash

# Metadata
script_name="Arch Linux Setup Script"
script_version="1.0"

# Script filenames in the desired execution order
declare -a script_filenames=(
  "timezone.sh"
  "locale.sh"
  "hostname.sh"
  "users.sh"
  "bootloader.sh"
)

# Directories
scripts_dir="./scripts"
chroot_setup_dir="/root/setup_scripts"

