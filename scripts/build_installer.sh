#!/bin/bash

echo -e "${MAGENTA}BUILD INSTALLER${NC}"

echo -e "${GREEN}>>> Creating installation file...${NC}"
MODULE_FILES=(
  "timezone.sh"
  "locale.sh"
  "hostname.sh"
  "users.sh"
  "bootloader.sh"
  "services.sh"
)

# Create temporary installation file
{
  echo "#!/bin/bash"
  cat "/tmp/${SETTINGS_FILE}"

  for module in "${MODULE_FILES[@]}"; do
    cat "${MODULES}/${module}"
  done
} > "/mnt/${INSTALLATION_FILE}"
