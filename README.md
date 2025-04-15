# 🚀 GCP Terraform + OPA Policy Enforcement Demo

This project demonstrates how to provision infrastructure on **Google Cloud Platform (GCP)** using **Terraform**, and validate it using **OPA (Open Policy Agent)** before deployment.  
It includes a real example of **policy validation**, **pass/fail scenarios**, and full CLI execution.

---

## 📦 Stack

- **Terraform**
- **Google Cloud Platform**
- **OPA (Open Policy Agent)**
- **Rego (Policy Language)**
- Cloud Shell / GitHub

---

## 🎯 What it does

✅ Creates two GCS buckets:
- One with label `env = dev` → ✅ *Allowed by policy*
- One with label `env = staging` → ❌ *Rejected by policy*

✋ The policy ensures that **only buckets with `env = dev` are allowed**.

---

## 🛠 How to run

```bash
terraform init
terraform plan -out=tfplan.binary
terraform show -json tfplan.binary > tfplan.json
opa eval --input tfplan.json --data policy/ --format pretty "data.validate.gcp.storage.deny"

📜 Rego Policy Logic
package validate.gcp.storage

deny := [msg |
  some i
  input.resource_changes[i].type == "google_storage_bucket"
  env := input.resource_changes[i].change.after.labels.env
  env != "dev"
  msg := sprintf("Invalid env label on bucket %s: %v (only 'dev' allowed)", [input.resource_changes[i].address, env])
]


📸 Screenshots
✅ Valid Bucket – Passes Policy
❌ Invalid Bucket – Rejected by Policy

🧠 Why this matters
Infrastructure as Code (IaC) and Policy as Code (PaC) are critical for scalable, secure, and automated platform engineering. This repo demonstrates how to combine Terraform and OPA for pre-deployment governance of GCP resources.