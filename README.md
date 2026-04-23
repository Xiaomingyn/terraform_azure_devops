# Introduction

This repository contains Terraform infrastructure-as-code for deploying Azure resources through Azure DevOps pipeline. 

It provisions a complete networking foundation in production environments, including:
- **Azure Resource Group**: Centralized management for all deployed resources
- **Virtual Network (VNet)**: 10.20.0.0/16 address space in Germany West Central
- **Subnet**: Application subnet (10.20.1.0/24) for workload deployment

The infrastructure is designed for scalability and follows Azure naming conventions with comprehensive tagging for resource management and cost tracking.

# Getting Started

## Prerequisites

Before you can deploy this infrastructure, ensure you have:
1. **Terraform**: Version 1.8.0 or higher (< 2.0.0)
2. **Azure CLI**: Latest version installed and authenticated
3. **Azure DevOps**: Access to the configured Azure subscription and DevOps project
4. **Service Principal**: With appropriate permissions to create resources in Azure

## Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd terraform_azure_devops
   ```

2. Install Terraform (if not already installed):
   - Visit [terraform.io/downloads](https://www.terraform.io/downloads.html)
   - Extract and add to your PATH

3. Install Azure CLI:
   ```bash
   # macOS
   brew install azure-cli
   
   # Ubuntu/Debian
   curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
   ```

## Configuration

The infrastructure is configured in the `infra/` directory:
- **variables.tf**: Input variables for customization
- **prod.tfvars**: Production environment values
- **providers.tf**: Azure provider configuration
- **versions.tf**: Terraform and provider version constraints
- **main.tf**: Resource definitions
- **outputs.tf**: Output values for reference

### Environment Variables

Set your Azure credentials:
```bash
export ARM_CLIENT_ID="<service-principal-id>"
export ARM_CLIENT_SECRET="<service-principal-password>"
export ARM_TENANT_ID="<azure-tenant-id>"
export ARM_SUBSCRIPTION_ID="<azure-subscription-id>"
```
**In this example, the required Azure credentials are mapped from a linked variable group defined under DevOps "Pipelines --> Library", which retrieves all credentials as secrets from an Azure KeyVault instance. **

## State Management

Terraform state is stored remotely in Azure Storage:
- **Storage Account**: YOUR-BLOB-STORAGE-ACCOUNT
- **Container**: tfstate (or change it to your container name)
- **State File**: terraform-azure-devops/prod.terraform.tfstate

# Build and Test

If you work with Azure DevOps pipelines, the easiest way to build it and make deployment is to create a pipeline based on the "azure-pipelines.yml" file and simply run the pipeline. 

If you decide to do it manually and step by step, please follow the instruction below:

## Validate Configuration

Validate Terraform syntax and configuration:
```bash
cd infra
terraform init
terraform validate
terraform fmt -check
```

## Plan Deployment

Generate a deployment plan to preview changes:
```bash
terraform plan -var-file=prod.tfvars -out=tfplan
terraform show tfplan
```

## Apply Changes

Deploy the infrastructure:
```bash
terraform apply tfplan
```

## View Outputs

After deployment, retrieve output values:
```bash
terraform output
```

## Automated Testing

This repository uses Azure DevOps Pipelines for automated validation:
- **Validate Stage**: Runs `terraform fmt` and `terraform validate`
- **Plan Stage**: Creates and artifacts the Terraform plan

Pipelines are triggered on:
- Push to `main` branch
- Pull requests against `main` branch

# Contribute

To contribute to this infrastructure project:

1. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes** and validate:
   ```bash
   cd infra
   terraform validate
   terraform fmt -recursive
   ```

3. **Test your changes**:
   ```bash
   terraform plan -var-file=prod.tfvars
   ```

4. **Commit with clear messages**:
   ```bash
   git commit -m "feat: add new resource" -m "Description of changes"
   ```

5. **Push and create a Pull Request**:
   - Ensure all checks pass in Azure DevOps
   - Request review from team members
   - Plan output will be automatically generated in PR comments

## Best Practices

- Always use `terraform fmt` before committing
- Validate changes with `terraform validate`
- Use descriptive variable and resource names
- Maintain consistent tagging strategy
- Test changes in the plan stage before applying
- Keep secrets in Azure DevOps variable groups (never commit them)