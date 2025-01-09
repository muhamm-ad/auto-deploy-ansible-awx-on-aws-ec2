# provider variables
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "aws_access_key" {
  description = "AWS access key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
}

variable "aws_access_token" {
  description = "AWS access token"
  type        = string
  default     = ""
}

variable "awx_server_ec2_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t2.xlarge"
}