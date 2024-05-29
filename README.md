# Jenkins Infrastructure with Terraform

This repository contains the Terraform configuration files to set up the infrastructure for a Jenkins server on AWS. The infrastructure includes a VPC, public subnet, internet gateway, route table, security group, and an EC2 instance running Jenkins.

## Prerequisites

Before getting started, ensure you have the following:

- AWS account with appropriate permissions
- Terraform installed on your local machine
- AWS CLI configured with the necessary credentials

## Repository Structure

The repository has the following structure:
├── infra.tf
├── provider.tf
├── variables.tf
├── versions.tf
└── .github
└── workflows
└── pull.yml

- `infra.tf`: The main Terraform configuration file that defines the infrastructure resources.
- `provider.tf`: Specifies the AWS provider and region for Terraform.
- `variables.tf`: Defines the input variables used in the Terraform configuration.
- `.github/workflows/pull.yml`: GitHub Actions workflow to validate Terraform configuration on pull requests.

## Infrastructure Components

The Terraform configuration creates the following infrastructure components:

- VPC: A Virtual Private Cloud to host the Jenkins EC2 instance.
- Public Subnet: A subnet within the VPC to place the Jenkins EC2 instance.
- Internet Gateway: Allows communication between the VPC and the internet.
- Route Table: Defines the routing rules for the public subnet.
- Security Group: Controls inbound and outbound traffic to the Jenkins EC2 instance.
- EC2 Instance: The instance running Jenkins with the specified AMI and instance type.
- Elastic IP: A static public IP address associated with the Jenkins EC2 instance.

## Usage

To deploy the Jenkins infrastructure using Terraform, follow these steps:

1. Clone this repository to your local machine.
2. Ensure that you have Terraform installed and the AWS CLI configured with the necessary credentials.
3. Review and modify the `variables.tf` file if needed, such as updating the AWS region, instance type, or AMI ID.
4. Run the `terraform init` following command to initialize Terraform.
5. Run the `terraform plan` command to preview the changes that Terraform will make.
6. If the plan looks good, run the `terraform apply` command to apply the changes and create the infrastructure.
7. Terraform will create the specified resources in your AWS account. Once the deployment is complete, you can accessnJenkins using the public IP or DNS of the EC2 instance.

## Destroying the Infrastructure

To destroy the Jenkins infrastructure and clean up the resources, run the `terraform destroy` command

Terraform will prompt you to confirm the destruction of the resources. Enter `yes` to proceed.

## GitHub Actions Workflow

The repository includes a GitHub Actions workflow:

- `pull.yml`: Triggered when a pull request is created against the main branch. It validates the Terraform configuration.

## Contributing

Please follow the standard GitHub workflow:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes and commit them with descriptive messages.
4. Push your changes to your forked repository.
5. Submit a pull request to the main repository.

Please ensure that your code follows the existing style and conventions used in the project.