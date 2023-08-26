terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}


#### CREATE RANDOM PASSWORD AND SAVE IT IN SECRETS MANAGER
resource "random_password" "password" {
    length = 16
    special = true
}

resource "aws_secretsmanager_secret" "random_password" {
    name = "prod/ec2/random_password"
}

resource "aws_secretsmanager_secret_version" "random_password" {
    secret_id = aws_secretsmanager_secret.random_password.id
    secret_string = random_password.password.result
}

output "random_password" {
    value = random_password.password.result
}

### SAVE SSH PRIVATE KEY IN SECRETS MANAGER

resource "tls_private_key" "ec2_key" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "aws_key_pair" "ec2_key" {
    key_name = "ec2_key"
    public_key = tls_private_key.ec2_key.public_key_openssh
}

resource "aws_secretsmanager_secret" "ec2_secret" {
    name = "prod/keypairs/ec2_secret"
}

resource "aws_secretsmanager_secret_version" "ec2_secret" {
    secret_id = aws_secretsmanager_secret.ec2_secret.id
    secret_string = tls_private_key.ec2_key.private_key_openssh
}

### CONSUME EXISTING REMOTE SECRET FROM SECRETS MANAGER

data "aws_secretsmanager_secret" "existing_secret" {
    name = "prod/ec2/password"
}

data "aws_secretsmanager_secret_version" "existing_secret_latest" {
    secret_id = data.aws_secretsmanager_secret.existing_secret.id
}

output "output_existing_secret" {
    value = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.ec2_secret_latest.secret_string))
}
