
# Terraform Security Pipeline with OPA (Open Policy Agent)

This project is a GitLab CI/CD-ready Terraform security pipeline. It integrates Open Policy Agent (OPA) using `conftest` to enforce infrastructure-as-code (IaC) compliance and security best practices.

---

## Project Structure

```
terraform-security-pipeline/
├── .gitlab-ci.yml
├── main.tf
├── variables.tf
├── outputs.tf
├── policies/
│   ├── no_public_sg.rego
│   ├── require_tags.rego
│   ├── no_t2_micro_prod.rego
│   ├── iam_least_privilege.rego
│   ├── encrypt_ebs.rego
│   └── s3_block_public_access.rego
```

---

## Prerequisites

- GitLab CI/CD setup
- Docker-enabled runner
- Terraform CLI installed
- `conftest` tool for OPA policy testing

Install conftest:
```bash
brew install conftest   # macOS
choco install conftest  # Windows
```

---

## Usage

### Step 1: Add Your Terraform Code
Edit `main.tf`, `variables.tf`, and `outputs.tf` to include your infrastructure code.

### Step 2: Review and Modify OPA Policies
Update policies under the `policies/` directory as needed. These are Rego policies used by OPA to scan your Terraform plans.

### Step 3: Run Pipeline

GitLab will automatically:
1. Run `terraform init`, `validate`, `plan`.
2. Use `terraform show -json` to convert your plan to JSON.
3. Use `conftest` to evaluate it against the OPA policies.

---

## Example Policies Enforced

- **No Public Security Groups:** Blocks `0.0.0.0/0` access
- **Required Tags:** Ensures resources have `Name`, `Environment`, and `Application` tags
- **No t2.micro in Prod:** Blocks `t2.micro` for production
- **IAM Least Privilege:** Denies `*` action/resource policies
- **EBS Encryption:** Requires encryption enabled
- **S3 Public Access:** Requires public access blocks

---

## Manual Testing (Optional)

To manually test using `conftest`:

```bash
terraform plan -out=tfplan.binary
terraform show -json tfplan.binary > tfplan.json
conftest test --policy policies tfplan.json
```

---

## Extend & Customize

You can add your own Rego policies in the `policies/` folder to enforce specific organizational security and compliance requirements.

---

## Questions?

Feel free to reach out for help or feature requests!
