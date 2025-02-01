#!/bin/bash

source ./config.sh
source ./functions.sh

echo "=========================================="
echo "$script_name (Version: $script_version)"
echo "=========================================="

show_loading "Partitioning disk" &
loading_pid=$!
bash ./scripts/disk.sh
if [[ $? -eq 0 ]]; then
  stop_loading "$loading_pid" "Disk partitioning completed successfully!"
else
  stop_loading "$loading_pid" "Disk partitioning failed!"
  exit 1
fi

