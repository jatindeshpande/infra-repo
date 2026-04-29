
data "aws_vpc" "default" {
    default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_caller_identity" "current"{}

output "debug_identity" {
  value = data.aws_caller_identity.current.arn
}

output "aws_subnet" {
  description = "Output the subnet id"
  value = data.aws_subnets.default.ids
}

output "subnet_cidr_block" {
  description = "The CIDR block of the created subnet"
  value       = data.aws_subnets.default
}

#ECR repo
resource "aws_ecr_repository" "app_repo" {
  name = "devops-app"
  image_scanning_configuration {
    scan_on_push = true
  }
  force_delete = true
}