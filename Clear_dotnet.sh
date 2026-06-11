#!/bin/bash

echo "=== Removing project folder ==="
rm -rf ~/3-Tier-Python-Postgres-Local-main

echo "=== Removing Python virtual environment ==="
rm -rf ~/myenv

echo "=== Removing Python packages installed globally (if any) ==="
sudo apt remove python3-pip -y
sudo apt remove python3.12-venv -y
sudo apt autoremove -y

echo "=== Stopping PostgreSQL ==="
sudo systemctl stop postgresql
sudo systemctl disable postgresql

echo "=== Dropping PostgreSQL database and user ==="
sudo -u postgres psql <<EOF
DROP DATABASE IF EXISTS my_database;
DROP USER IF EXISTS root;
EOF

echo "=== Removing PostgreSQL completely ==="
sudo apt-get --purge remove postgresql postgresql-contrib -y
sudo apt-get autoremove -y
sudo apt-get autoclean -y

echo "=== Uninstall complete ==="

