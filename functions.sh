#!/bin/bash

error_exit() {
  echo "Error $1" >&2
}

validate_file() {
  if [[ ! -f "$1" ]]; then
    error_exit "File '$1' does not exist."
  fi
}

validate_directory() {
  if [[ ! -d "$1" ]]; then
    error_exit "Directory '$1' does not exist."
  fi
}

show_loading() {
  local delay=0.1
  local spin_chars=('|' '/' '-' '\')
  local i=0

  while true; do
    printf "\r[%s] Loading %s..." "${spin_chars[i]}" "$1"
    i=$(( (i + 1) % 4 ))
    sleep "$delay"
  done
}

stop_loading() {
  kill "$1" 2>/dev/null
  printf "\r%s\n" "$2"
}
