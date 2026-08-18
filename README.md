# Cloud Resume Challenge - Azure

My implementation of the Cloud Resume Challenge using Microsoft Azure.

URL: https://www.janinocencio.xyz/

## Architecture

The project consists of:

- Azure Storage Account Static Website for the frontend
- Azure Function App for the visitor counter API
- Azure Cosmos DB Table API for storing the visitor count
- Custom domain and DNS Management through Porkbun and Cloudflare
- Terraform for Infrastructure as Code
- GitHub Actions for CI/CD
- GitHub Actions OIDC for passwordless Azure authentication

## Project Structure

```text
cloud-resume-challenge/
├── .github/
│   └── workflows/
│       ├── frontend.yml
│       └── backend.yml
│
└── crc/
    ├── frontend/
    │   ├── index.html
    │   ├── style.css
    │   └── script.js
    │
    ├── backend/
    │   ├── function_app.py
    │   ├── host.json
    │   └── requirements.txt
    │
    └── terraform/
        ├── providers.tf
        ├── resource_group.tf
        ├── storage.tf
        ├── cosmos.tf
        ├── function_app.tf
        ├── app_service_plan.tf
        ├── application_insights.tf
        ├── variables.tf
        ├── outputs.tf
        ├── terraform.tfvars.example
        ├── .gitignore
        └── README.md
```

## Azure Resources


| Resource | Purpose |
| -------- | -------- |
| Azure Storage Account | Hosts the static frontend |
| Azure Function App | Provides the visitor counter API |
| Azure Cosmos DB Table API | Stores visitor count data |
| Application Insights | Function monitoring |
| App Service Plan | Function hosting |
| Resource Group | Contains project resources |


## Frontend

The frontend is a static HTML/CSS/JavaScript website hosted using Azure Storage Static Website hosting.
The JavaScript frontend calls the Azure Function API to retrieve and update the visitor count.

## Backend

The backend uses an Azure Function written in Python.

The Function:

1. Receives an HTTP request from the frontend.
2. Connects to Azure Cosmos DB Table API.
3. Retrieves the current visitor count.
4. Increments the count.
5. Returns the updated count as JSON.

## Infrastructure as Code (IaC)

Terraform is used to manage the Azure infrastructure.

Terraform manages resources including:

- Resource Group
- Storage Account
- Cosmos DB
- Function App
- App Service Plan
- Application Insights

Terraform state files and files containing secrets are excluded from Git using .gitignore.

## CI/CD

GitHub Actions automatically deploys changes to Azure.

## Frontend

Changes under:

- `crc\frontend**`

trigger the frontend workflow as follows:

1. Checks out the repository.
2. Authenticates to Azure using OIDC.
3. Uploads the frontend files to the Azure Storage `$web` container.

## Backend

Changes under:

- `crc\backend**`

trigger the backend workflow as follows:

1. Checks out the repository.
2. Authenticates to Azure using OIDC.
3. Builds and deploys the Python Azure Function.

## Authentication

GitHub Actions uses OpenID Connect (OIDC) to authenticate to Azure.
No Azure client secret is stored in the GitHub repository.
The GitHub Actions service principal is granted only the permissions required for deployment.

## Deployment Flow

```text
Developer
    │
    │ git push
    ▼
GitHub Repository
    │
    ├── crc/frontend/** changed
    │       │
    │       ▼
    │   Frontend CI/CD
    │       │
    │       │ OIDC
    │       ▼
    │   Azure Storage ($web)
    │       │
    │       ▼
    │   Live Website
    │
    │
    └── crc/backend/** changed
            │
            ▼
        Backend CI/CD
            │
            │ OIDC
            ▼
        Azure Function
            │
            ▼
        Cosmos DB
```

## Application Flow

```text
Visitor
   │
   │ Opens website
   ▼
Azure Storage ($web)
   │
   │ Loads HTML / CSS / JavaScript
   ▼
Live Website
   │
   │ HTTP request
   │ GET /api/visitorcounter
   ▼
Azure Function
   │
   │ Read current visitor count
   │ Increment count
   │ Save updated count
   ▼
Azure Cosmos DB
   │
   │ Returns updated count
   ▼
Azure Function
   │
   │ JSON response
   ▼
Live Website
   │
   ▼
Visitor counter displayed
```

## Technologies

- Microsoft Azure
- Azure Storage
- Azure Functions
- Azure Cosmos DB
- Terraform
- GitHub Actions
- GitHub OIDC
- Python
- HTML
- CSS
- JavaScript
- Porkbun
- Cloudflare

## Future Improvements

- Add automated testing to the CI/CD pipelines.
- Add monitoring and alerting for the application.
- Improve the frontend design and responsiveness.
- Add separate development and production environments.
- Further improve the Terraform modules and infrastructure structure.