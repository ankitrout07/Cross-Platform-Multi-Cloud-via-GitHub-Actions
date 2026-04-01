# 🏗️ The Universal Architecture: Script-Based Multi-Cloud Patching

This repository is the **Single Source of Truth** for the patching state of your global fleet (Azure + AWS). 

## 🚀 Unified Strategy
Instead of hardcoding logic in YAML, we use specialized scripts that are executed across both cloud providers. This ensures version control and auditability of your patching logic.

### 1. The Trigger Mechanism
- **Push (Automatic)**: Updating any script in `scripts/ubuntu/` or `scripts/windows/` and pushing to `main` immediately triggers the corresponding OS-specific workflow.
- **Workflow Dispatch (Manual)**: The "Big Green Button." Manually trigger a patch run for zero-day vulnerabilities or on-demand maintenance.

### 2. OS-Specific Workflows
| Workflow | Target OS | Logic Source | Tools Used |
| :--- | :--- | :--- | :--- |
| **Ubuntu-MultiCloud-Patching** | Ubuntu 24.04+ | `scripts/ubuntu/patch.sh` | `apt`, `az run-command`, `aws ssm` |
| **Windows-MultiCloud-Patching** | Windows Server | `scripts/windows/patch.ps1` | `PSWindowsUpdate`, `Chocolatey`, `KBs` |

---

## 📂 Repository Structure
```text
.github/workflows/
  ├── ubuntu-patching.yml    # Targets Azure + AWS Ubuntu
  └── windows-patching.yml   # Targets Azure + AWS Windows
scripts/
  ├── ubuntu/
  │   └── patch.sh           # Core logic for Linux patching
  └── windows/
      └── patch.ps1          # Core logic for Windows patching
```

---

## 🛠️ Configuration Checklist (AWS)
To ensure AWS instances respond to these workflows:
1. **Tagging**: Tag your instances with `OS=Ubuntu` or `OS=Windows`.
2. **OIDC**: Ensure the GitHub Actions IAM Role has `AmazonSSMFullAccess`.
3. **SSM Agent**: Verify the agent is "Online" via the AWS Console or CLI.

---

## ✅ Fleet Status Validation
Check the real-time status of your patching deployment:

### Azure Status
```bash
az vm get-instance-view -g Cross-Platform-Update -n Ubuntu --query "instanceView.patchStatus"
```

### AWS Status
```bash
aws ssm list-command-invocations --details --query "CommandInvocations[*].{Instance:InstanceId,Status:Status}"
```
