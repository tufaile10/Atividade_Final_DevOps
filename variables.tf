
variable "aws_region" {
  description = "AWS region to deploy"
  type        = string
  default     = "sa-east-1"
}

# variable "aws_profile" {
#   description = "AWS CLI profile name"
#   type        = string
#   default     = null
# }

variable "project_name" {
  description = "Name prefix for resources"
  type        = string
  default     = "atividade3"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of public subnet CIDRs (2 AZs)"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of private subnet CIDRs (2 AZs)"
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "ec2_instance_type" {
  type        = string
  default     = "t3.micro"
  description = "EC2 instance type"
}

variable "db_engine" {
  type        = string
  default     = "mysql"
  description = "RDS engine (mysql or postgres, etc.)"
}

variable "db_engine_version" {
  type        = string
  default     = "8.0"
  description = "RDS engine version"
}

variable "db_username" {
  type        = string
  default     = "appuser"
  description = "Master username for RDS"
}

variable "db_name" {
  type        = string
  default     = "appdb"
  description = "Initial database name"
}

variable "create_key_pair_name" {
  type        = string
  default     = null
  description = "Optional existing EC2 Key Pair name for SSH. If null, SSH will not be open."
}

variable "open_ssh_cidr" {
  type        = string
  default     = null
  description = "CIDR to allow SSH access (e.g., 1.2.3.4/32). If null, SSH is not allowed."
}
