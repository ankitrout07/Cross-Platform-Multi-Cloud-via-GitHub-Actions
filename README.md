# 🏗️ Universal Multi-Cloud Patching Command Center

This project implements a professional, high-uptime automation suite for cross-platform system maintenance. Using **GitHub Actions**, **Azure OIDC**, and **AWS OIDC (Mumbai)**, it provide a centralized "Remote Control" for patching your global fleet of Ubuntu and Windows instances.

## 🌟 The "Matrix-style" Selector
The project's centerpiece is a **Single-Cloud Patching Selector** that allows you to target specific environments or your entire global fleet in a single run.

| Feature | Target | Selection Logic |
| :--- | :--- | :--- |
| **Cloud Provider** | AWS, Azure, BOTH | Dynamic OIDC Login & CLI Targeting |
| **OS Type** | Ubuntu, Windows, BOTH | OS-Specific Scripts & Documentation |

---

## 📂 Repository Structure
The repository is the **Single Source of Truth** for your patching state:
```text
.github/workflows/
  ├── patching-selector.yml  # Matrix Selector (Dropdown Tool)
  ├── ubuntu-patching.yml    # Automatic & Specialized Ubuntu Patching
  └── windows-patching.yml   # Automatic & Specialized Windows Patching

scripts/
  ├── ubuntu/
  │   └── patch.sh           # Core logic for Linux (apt, kernel headers)
  └── windows/
      └── patch.ps1          # Core logic for Windows (PSUpdate, Choco)
```

---

## 🛠️ Getting Started
For detailed steps on setting up OIDC, tagging your infrastructure, and triggering your first run, please refer to the:

👉 **[HOW_TO_RUN.md](./HOW_TO_RUN.md)**

---

## ✅ Fleet Status Reporting
Run these validation commands from your terminal to monitor your global patching status after a workflow completes:

### Azure Infrastructure (Status)
```bash
az vm get-instance-view -g Cross-Platform-Update -n Ubuntu --query "instanceView.patchStatus"
```

### AWS Infrastructure (Status)
```bash
aws ssm list-command-invocations --details --query "CommandInvocations[*].{Instance:InstanceId,Status:Status}"
```

---

## 🔒 Security Policy
This project strictly follows a **Secretless Architecture** using OpenID Connect (OIDC). No long-lived access keys or credentials are stored within the repository.
