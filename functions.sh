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
  local delay=0.2
  local spin_chars=('/' '-' '\' '|')
  local i=0

  stty -echo  # Desactiva eco para mejor rendimiento
  while true; do
    printf "\r[%s] Loading %s..." "${spin_chars[i]}" "$1"
    i=$(( (i + 1) % 4 ))
    sleep "$delay"
  done
  stty echo
}

stop_loading() {
  local pid="$1"
  local result="$2"
  local output="${3:-}"

  kill "$pid" 2>/dev/null
  wait "$pid" 2>/dev/null

  printf "\r\033[K%s\n" "$result"

  [[ -n "$output" ]] && echo -e "\nDetails:\n$output"
}

execute_with_loading() {
  local command="$1"
  local command_desc="$2"

  show_loading "$command_desc" &
  local loading_pid=$!

  local output exit_code
  output=$(bash -c "$command" 2>&1)
  exit_code=$?
  
  if [[ $exit_code -eq 0 ]]; then
    stop_loading "$loading_pid" "[OK] $command_desc"
  else
    stop_loading "$loading_pid" "[ERROR] $command_desc" "$output"
    return 1
  fi
}
