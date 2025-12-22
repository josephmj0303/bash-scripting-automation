# Bash Scripting Automation for System Administration

This repository contains **real-world Bash scripts** used to automate common Linux system administration tasks.

The goal of this project is to demonstrate **practical Bash scripting skills** that are directly applicable to DevOps and SysAdmin roles.

## 🔹 Advanced Automation Projects

### Cross-VPS Backup System (Debian ⇄ AlmaLinux)
A production-grade, bidirectional backup system using Bash, rsync, SSH keys, cron, and date-based retention.

✔ Cross-server disaster recovery  
✔ Secure SSH automation  
✔ Deterministic retention logic  
✔ Real-world failure handling  

📂 Location: `Backups & Maintenance: cross-vps-backup-system/`


---

## 🔧 Skills Demonstrated

- Bash variables, conditions, loops
- Functions and exit handling
- File and user management
- Monitoring and alerting logic
- Cron-ready automation
- Safe scripting practices

---

## 📂 Script Categories

### 👤 User Management
- Create users with sudo access
- Bulk user creation from file

### 📊 Monitoring
- CPU usage monitoring
- Disk usage alerts

### 💾 Backups & Maintenance
- Log rotation
- Home directory backups
- cross-vps-backup-system
- restore-from-backup.sh

### 🛠 Utilities
- Temporary file cleanup
- Interactive menu-based automation

---

## ▶️ How to Run

```bash
chmod +x <script-name>.sh
./<script-name>.sh
```
Some scripts require sudo.
---
## Related Projects

- [bash-multi-node-web-deployment](https://github.com/josephmj0303/bash-multi-node-web-deployment)
  - Multi-node web deployment using SSH and sudo

---
📌 Why This Repo Matters

This project demonstrates foundational automation skills that DevOps engineers rely on before introducing tools like Ansible or Terraform.

It shows the ability to:

* Automate repetitive tasks

* Write safe and readable Bash
