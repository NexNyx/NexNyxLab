#!/bin/bash
# NexNyx init - installs tools and creates folder structure
set -e

echo "[*] Updating system..."
sudo apt update && sudo apt upgrade -y

echo "[*] Installing tools..."
sudo apt install -y nmap curl git python3 python3-pip nikto gobuster jq xclip wl-clipboard

echo "[*] Installing sslyze..."
pip3 install --user sslyze || true

echo "[*] Creating project structure..."
mkdir -p ~/NexNyxLab/{scripts,results,templates,docs,reports}

echo "[*] Done. Repo: ~/NexNyxLab"
