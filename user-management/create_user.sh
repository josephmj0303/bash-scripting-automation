
---

# REAL SCRIPTS (Production-Style)

---

## `user-management/create_user.sh`

```bash
#!/bin/bash

USER_NAME=$1

if [[ -z "$USER_NAME" ]]; then
  echo "Usage: $0 <username>"
  exit 1
fi

if id "$USER_NAME" &>/dev/null; then
  echo "User $USER_NAME already exists"
  exit 1
fi

useradd -m -s /bin/bash "$USER_NAME"
echo "$USER_NAME:ChangeMe123" | chpasswd
usermod -aG sudo "$USER_NAME"

echo "User $USER_NAME created with sudo access"
