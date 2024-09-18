# Jenkins Infrastructure with Terraform

This repository contains the Terraform configuration files to set up the infrastructure for a Jenkins server on AWS. The infrastructure includes a VPC, public subnet, internet gateway, route table, security group, and an EC2 instance running Jenkins.

## Prerequisites

Before getting started, ensure you have the following:

- AWS account with appropriate permissions
- Terraform installed on your local machine
- AWS CLI configured with the necessary credentials

## Repository Structure

The repository has the following structure:
```
├── infra.tf
├── provider.tf
├── variables.tf
├── versions.tf
└── .gitignore
└── Jenkinsfile
```

- `infra.tf`: The main Terraform configuration file that defines the infrastructure resources.
- `provider.tf`: Specifies the AWS provider and region for Terraform.
- `variables.tf`: Defines the input variables used in the Terraform configuration.
- `Jenkinsfile`: GitHub Actions workflow to validate Terraform configuration on pull requests.

## Infrastructure Components

The Terraform configuration creates the following infrastructure components:

- VPC: A Virtual Private Cloud to host the Jenkins EC2 instance.
- Public Subnet: A subnet within the VPC to place the Jenkins EC2 instance.
- Internet Gateway: Allows communication between the VPC and the internet.
- Route Table: Defines the routing rules for the public subnet.
- Security Group: Controls inbound and outbound traffic to the Jenkins EC2 instance.
- EC2 Instance: The instance running Jenkins with the specified AMI and instance type.
- Elastic IP: A pre-created static public IP address is associated with the Jenkins EC2 instance.

## Usage

To deploy the Jenkins infrastructure using Terraform, follow these steps:

1. Clone this repository to your local machine.
2. Ensure that you have Terraform installed and the AWS CLI configured with the necessary credentials.
3. Review and modify the `variables.tf` file if needed, such as updating the AWS region, instance type, or AMI ID.
4. Run the `terraform init` following command to initialize Terraform.
5. Run the `terraform plan` command to preview the changes that Terraform will make.
6. If the plan looks good, run the `terraform apply` command to apply the changes and create the infrastructure.
7. Terraform will create the specified resources in your AWS account. Once the process is complete, you will see the output with the public IP address of the Jenkins server.

## Destroying the Infrastructure

To destroy the Jenkins infrastructure and clean up the resources, run the `terraform destroy` command

Terraform will prompt you to confirm the destruction of the resources. Enter `yes` to proceed.

## CI/CD Pipeline
This repository follows a CI/CD process that integrates GitHub and Jenkins using webhooks to trigger automated workflows. The CI/CD process ensures that code quality, infrastructure validation, and versioning are handled automatically before code can be merged and released.

### CI/CD Workflow Overview
#### GitHub -> Jenkins Integration
- GitHub Webhook: A webhook is configured on this repository to trigger Jenkins jobs on specific GitHub events (e.g., pull requests).
- Jenkins Pipelines: There is a single Jenkins pipelines (JenkinsFile) that handle Terraform code validation, and commit message validation using Conventional Commits standard.

#### CI/CD Pipeline Flow
##### Code Validation and commit message validation:

- Trigger: Pull requests to the main branch
- This pipeline performs several checks to ensure the quality and validity of the Terraform infrastructure code and that the commit messages adhere to the Conventional Commits standard before allowing a merge.

## Multiple Environments
In order to deploy this infrastructure in multiple environments without duplicating the code and while maintaining distinct Terraform state files, I'd recommend using Terraform Workspaces
1. **Create a new workspace:**
   ```bash
   terraform workspace new workspacenew
2. **Switch to the new workspace:**
   ```bash
   terraform workspace select workspacenew 
3. **List workspaces:**
   ```bash
   terraform workspace list 
4. **Delete a workspace:**
   ```bash
   terraform workspace select default 
   terraform workspace delete workspacenew 