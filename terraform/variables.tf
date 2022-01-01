variable "region" {
  description = "Region in which to build the resource."
  default     = "ap-northeast-1"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The IP address range of the VPC in CIDR notation."
  default     = "10.0.0.0/16"
  type        = string
}

variable "vpn_client_cidr_block" {
  default = "10.1.0.0/16"
  type    = string
}
