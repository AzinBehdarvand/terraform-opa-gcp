# 🚀 GCP Terraform + OPA Policy Enforcement Demo

This project demonstrates using **Terraform** to provision resources on **Google Cloud Platform (GCP)** and validating infrastructure using **OPA (Open Policy Agent)** before deployment.

## 📦 Stack
- Terraform
- Google Cloud Platform
- OPA (Open Policy Agent)
- Rego
- Cloud Shell (optional)

## 🎯 What it does

- Provisions two GCS buckets:
  - ✅ `test_valid` with `env = dev` → Allowed by policy
  - ❌ `test_invalid` with `env = staging` → Rejected by policy

## 📜 Policy Example (Rego)

```rego
deny := [msg |
  some i
  input.resource_changes[i].type == "google_storage_bucket"
  env := input.resource_changes[i].change.after.labels.env
  env != "dev"
  msg := sprintf("Invalid env label on bucket %s: %v (only 'dev' allowed)", [input.resource_changes[i].address, env])
]

✅ How to run
terraform init
terraform plan -out=tfplan.binary
terraform show -json tfplan.binary > tfplan.json
opa eval --input tfplan.json --data policy/ --format pretty "data.validate.gcp.storage.deny"

📸 Screenshots
✅ Valid Bucket – Passes Policy
❌ Invalid Bucket – Policy Denied

💡 Notes
No actual GCP resources are created until you run terraform apply

OPA is used as a pre-deployment validation layer