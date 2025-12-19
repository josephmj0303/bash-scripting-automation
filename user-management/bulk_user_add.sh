#!/bin/bash

USER_FILE="users.txt"

if [[ ! -f $USER_FILE ]]; then
  echo "User file not found"
  exit 1
fi

while read user; do
  if id "$user" &>/dev/null; then
    echo "$user already exists"
  else
    useradd -m "$user"
    echo "$user:Welcome123" | chpasswd
    echo "Created user $user"
  fi
done < "$USER_FILE"
