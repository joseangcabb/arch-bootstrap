#!/bin/bash

read_password() {
  local prompt=$1 var=$2
  while true; do
    read -rsp "${prompt}" "$var"
    echo
    read -rsp "Confirm ${prompt}" confirm
    echo
    if [[ "${!var}" == "$confirm" ]]; then
      break
    fi
    echo "Passwords do not match. Try again."
  done
}


