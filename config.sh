#!/bin/bash

# Metadata
script_name="Arch Linux Setup Script"
script_version="1.0"

# Script filenames in the desired execution order
script_filenames=(
  "timezone.sh"
  "locale.sh"
  "hostname.sh"
  "users.sh"
  "bootloader.sh"
)

# Directories
script_source_dir="./scripts"
chroot_dir="/mnt/root/setup_scripts"
