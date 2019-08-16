terraform {
  backend "s3" {
    bucket = "YOUR_BUCKET"
    region = "us-east-1"
    workspace_key_prefix = "terraform-state/your-project"
    key = "terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
  version = "~> 2.23"
}

module "my_db_name" {
  source = "github.com/labelinsight/terraform-aws-ssm-parameter"
  description = "The name of my example parameter"
  value = "my-database"
}

resource "aws_dynamodb_table" "my_db" {
  name = module.my_db_name.ssm_parameter_value
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "id"
  attribute {
    name = "id"
    type = "S"
  }
}

output "ssm_parameter_name" {
  value = module.my_db_name.ssm_parameter_name
}

output "ssm_parameter_value" {
  value = module.my_db_name.ssm_parameter_value
}