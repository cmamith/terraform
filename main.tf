provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  backend "s3" {
    bucket         = "my-terraform-example-bucket-2025"
    key            = "terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "terraform-lock-table"
  }
}

module "vpc" {
  source                  = "./modules/vpc"
  vpc_cidr_block          = var.vpc_cidr_block
  public_subnet_cidr      = var.public_subnet_cidr
  public_subnet_az        = var.public_subnet_az
  private_subnet_1_cidr   = var.private_subnet_1_cidr
  private_subnet_1_az     = var.private_subnet_1_az
  private_subnet_2_cidr   = var.private_subnet_2_cidr
  private_subnet_2_az     = var.private_subnet_2_az
}

module "ec2_instance" {
  source         = "./modules/ec2_instance"
  instance_type  = var.instance_type
  subnet_id      = module.vpc.public_subnet_id # Using the output from VPC module
  public_ip      = true
  instance_name  = "my-ec2-instance"
}


resource "aws_s3_bucket" "bucket" {
  bucket = "my-terraform-example-bucket-2025"

  tags = {
    Name        = "TerraformExampleBucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_lock_table" {
  name         = "terraform-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "TerraformLockTable"
    Environment = "Dev"
  }
}

output "ec2_instance_id" {
  value = module.ec2_instance.instance_id
}

output "ec2_instance_public_ip" {
  value = module.ec2_instance.instance_public_ip
}
