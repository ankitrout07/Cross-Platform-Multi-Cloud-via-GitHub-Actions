#!/bin/bash
# 🏗️ Multi-Cloud Ubuntu Patching Script
# Single Source of Truth for Patching State
set -e

echo "=== Starting Multi-Cloud Ubuntu Patching ==="
echo "Operating System: $(lsb_release -d | cut -f2-)"

# Update package lists
sudo apt-get update

# Install security updates (Non-interactive)
echo "Installing Critical and Security updates..."
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

echo "=== Patching complete. Checking for reboot requirement... ==="
if [ -f /var/run/reboot-required ]; then
    echo "Reboot is required. Rebooting now..."
    sudo reboot
else
    echo "No reboot required."
fi
