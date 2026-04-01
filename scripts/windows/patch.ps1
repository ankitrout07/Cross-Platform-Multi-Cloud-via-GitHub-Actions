# 🏗️ Multi-Cloud Windows Patching Script
# Single Source of Truth for Windows KB Patching State

Write-Output "=== Starting Multi-Cloud Windows Patching ==="

# 1. Install PSWindowsUpdate module if not present
if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Write-Output "Installing NuGet provider and PSWindowsUpdate module..."
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Install-Module -Name PSWindowsUpdate -Force -Confirm:$false
}
Import-Module PSWindowsUpdate

# 2. Update Chocolatey packages if present
if (Get-Command choco -ErrorAction SilentlyContinue) {
    Write-Output "Upgrading Chocolatey packages..."
    choco upgrade all -y
}

# 3. Install Windows Updates (KBs, Security, etc.)
Write-Output "Checking and installing Windows updates..."
Get-WindowsUpdate -AcceptAll -Install -AutoReboot -Verbose
