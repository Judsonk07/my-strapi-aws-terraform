variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.small"
}

variable "public_key_path" {
  description = "Path to SSH public key"
  type        = string
  # adjust if your username is different
  default     = "C:/Users/pappa/.ssh/id_rsa.pub"
}
