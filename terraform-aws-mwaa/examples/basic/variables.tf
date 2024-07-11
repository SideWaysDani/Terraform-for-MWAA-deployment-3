variable "name" {
  description = "Name of MWAA Environment"
  default     = "azure-pipeline-mwaa-3"
  type        = string
}

variable "region" {
  description = "region"
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  description = "Default tags"
  default     = {}
  type        = map(string)
}

variable "vpc_cidr" {
  description = "VPC CIDR for MWAA"
  type        = string
  default     = "10.3.0.0/16"
}
