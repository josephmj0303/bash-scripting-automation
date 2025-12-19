#!/bin/bash

while true; do
  echo "1) Check disk usage"
  echo "2) Check memory usage"
  echo "3) List logged-in users"
  echo "4) Exit"
  read -p "Choose an option: " choice

  case $choice in
    1) df -h ;;
    2) free -m ;;
    3) who ;;
    4) exit 0 ;;
    *) echo "Invalid choice" ;;
  esac
done
