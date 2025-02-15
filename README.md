Terraform Project - AWS Infrastructure Setup

Overview

This Terraform project is designed to set up a basic AWS infrastructure. It includes a Virtual Private Cloud (VPC) with subnets, an internet gateway, and an EC2 instance. The project is modularized, making it easy to customize and extend.

Prerequisites

An AWS account

Terraform installed (https://www.terraform.io/downloads.html)

AWS CLI installed and configured with credentials

Project Structure

.
├── main.tf              # Root configuration file
├── variables.tf         # Input variables for the root module
├── outputs.tf           # Outputs from the root module
├── terraform.tfvars     # Variable values (user-specific)
├── modules/
│   ├── ec2_instance/    # EC2 instance module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── vpc/             # VPC module
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf

What This Project Does

Creates an AWS VPC with 3 subnets (1 public, 2 private)

Sets up an Internet Gateway for the public subnet

Deploys an EC2 instance in the public subnet

Getting Started

1. Clone the Repository

git clone <repo-url>
cd <repo-folder>

2. Initialize Terraform

terraform init

3. Customize Variables

Edit terraform.tfvars to match your desired configuration. Example:

vpc_cidr_block = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"
public_subnet_az = "ap-southeast-1a"
private_subnet_1_cidr = "10.0.2.0/24"
private_subnet_1_az = "ap-southeast-1b"
private_subnet_2_cidr = "10.0.3.0/24"
private_subnet_2_az = "ap-southeast-1c"
instance_type = "t2.micro"

4. Plan the Deployment

terraform plan

5. Apply the Changes

terraform apply

6. View Outputs

After successful deployment, Terraform will display outputs like the EC2 instance ID and public IP.

Cleanup

To destroy the infrastructure:

terraform destroy

Best Practices

Use terraform.tfvars for your environment-specific values.

Enable S3 backend + DynamoDB for state locking in production.

Use environment variables for sensitive information.

Useful Commands

Command

Description

terraform init

Initialize Terraform project

terraform plan

Show the execution plan

terraform apply

Apply the configuration

terraform destroy

Destroy the resources

terraform output

Display output values

References

Terraform Documentation: https://www.terraform.io/docs/index.html

AWS CLI: https://aws.amazon.com/cli/

Happy Terraforming!


