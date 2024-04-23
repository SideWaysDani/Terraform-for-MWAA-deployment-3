#####################################################################################
# Terraform module examples are meant to show an _example_ on how to use a module
# per use-case. The code below should not be copied directly but referenced in order
# to build your own root module that invokes this module
#####################################################################################
provider "aws" {
  region = var.region  
}

module "mwaa" {
  source = "../.."  
  name   = var.mwaa_name 
  region = var.region 

  # ... Assuming your module handles VPC and security groups internally...
  # ... If not, you'd likely need to pass VPC and subnet references.

  # Potential Airflow configuration (If your module supports it):
  airflow_configuration_options = {
    "core.load_default_connections" = "false"
    "core.load_examples"            = "false" 
    # ... other Airflow config options ...
  }

  # Assuming a variable 'environment_class' in your module:
  environment_class = "mw1.medium" 

  tags = var.tags 
}

#---------------------------------------------------------------
# Supporting Resources
#---------------------------------------------------------------
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = var.name
  cidr = var.vpc_cidr

  azs             = local.azs
  public_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k)]
  private_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 10)]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = var.tags
}
