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

module "ec2_instance" {
  source         = "./modules/ec2_instance"
  instance_type  = "t2.micro"
  subnet_id      = module.vpc.public_subnet_id # 👈 Public Subnet
  public_ip      = true
  instance_name  = "my-ec2-instance"
}

module "vpc" {
  source                  = "./modules/vpc"
  vpc_cidr_block          = "10.0.0.0/16"
  public_subnet_cidr      = "10.0.1.0/24"
  public_subnet_az        = "ap-southeast-1a"
  private_subnet_1_cidr   = "10.0.2.0/24"
  private_subnet_1_az     = "ap-southeast-1b"
  private_subnet_2_cidr   = "10.0.3.0/24"
  private_subnet_2_az     = "ap-southeast-1c"
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
