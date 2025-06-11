#        DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
#                    Version 2, December 2004 
#
# Copyright (C) 2025 Thomas Ferry <thomas.ferry@gmail.com> 
#
# Everyone is permitted to copy and distribute verbatim or modified 
# copies of this license document, and changing it is allowed as long 
# as the name is changed. 
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION 
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.

#Autoinstall NVIDIA v.1


#!/bin/bash

# Ensure the script is run as root
if [[ "$EUID" -ne 0 ]]; then
  echo "Please run this script as root or with sudo"
  exit 1
fi

# Get Debian release to ensure this isn't ran on anything other than Debian 13. 
CODENAME=$(lsb_release -cs)

# Check if the codename is 'trixie'
if [[ "$CODENAME" != "trixie" ]]; then
  echo "This script only supports Debian Trixie. Current codename is: $CODENAME"
  exit 1
fi

echo "Detected Debian 13 Trixie."

# Update package index
echo "Updating Package Repos"
apt update

# Install kernel headers
echo "Installing kernel headers... because the Debian devs want to fix want isn't broken. Good Job."
apt install -y linux-headers-$(uname -r)

# Install nvidia-driver package
echo "Installing NVIDIA driver from Debian repository..."
apt install -y nvidia-driver

# Check if NVIDIA driver installed successfully
if command -v nvidia-smi &>/dev/null; then
  echo "NVIDIA driver installed successfully."
else
  echo "NVIDIA driver installation may have failed. Please dmesg check logs."
fi