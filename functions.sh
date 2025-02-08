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
  local msg="$1"
  local delay=0.1
  local spinchars='|/-\'
  while true; do
    for ((i=0; i<${#spinchars}; i++)); do
      echo -ne "\r${msg} ${spinchars:$i:1}"
      sleep "$delay"
    done
  done
}

stop_loading() {
  kill "$1" 2>/dev/null
  echo -e "\r$2"
}

execute_with_loading() {
  local command="$1"
  local command_desc="$2"

  show_loading "$command_desc" &
  local loading_pid=$!

  bash -c "$command"
  local exit_code=$?

  if [[ $exit_code -eq 0 ]]; then
    stop_loading "$loading_pid" "[OK] $command_desc"
  else
    stop_loading "$loading_pid" "[ERROR] $command_desc"
    return 1
  fi
}
