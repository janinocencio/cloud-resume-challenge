# Terraform Infrastructure

Terraform configuration for the Azure Cloud Resume Challenge.

## Azure Resources

This configuration manages the following Azure resources:

- Resource Group
- Azure Storage Account with Static Website
- Azure Function App
- App Service Plan
- Azure Cosmos DB Table API
- Application Insights

## Region

All resources are deployed in:

`Australia East`

## Prerequisites

- Azure CLI
- Terraform
- An authenticated Azure CLI session
- A `terraform.tfvars` file containing the required variables

## Required Variable

The Terraform configuration requires:

`cosmos_table_connection`

See `terraform.tfvars.example` for the expected format.

> Do not commit `terraform.tfvars` because it contains sensitive credentials.

## Terraform Commands

Initialize Terraform:

```powershell
terraform init