variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "custom" # Change to your preferred prefix  
}
variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
}

variable "cluster_endpoint" {
  description = "EKS Cluster endpoint"
  type        = string
  default     = "" # Set to your cluster endpoint
}
variable "assume_role_arn" {
  description = "ARN of IAM role to assume (if needed)"
  type        = string
  default     = null
}
variable "cluster_certificate_authority_data" {
  description = "EKS Cluster certificate authority data"
  type        = string
  default     = "" # Set to your cluster CA data
}
variable "oidc_provider_arn" {
  description = "OIDC provider ARN for the EKS cluster"
  type        = string
  default     = "" # Set to your OIDC provider ARN
}
variable "cluster_oidc_issuer_url" {
  description = "OIDC issuer URL for the EKS cluster"
  type        = string
  default     = "" # Set to your OIDC issuer URL
}
variable "vpc_id" {
  description = "VPC ID for the EKS cluster"
  type        = string
  default     = "" # Set to your VPC ID
}
variable "private_subnets" {
  description = "List of private subnets for the EKS cluster"
  type        = list(string)
  default     = [] # Set to your private subnets
}
variable "public_subnets" {
  description = "List of public subnets for the EKS cluster"
  type        = list(string)
  default     = [] # Set to your public subnets
}
variable "node_security_group_id" {
  description = "Security group ID for the EKS nodes"
  type        = string
  default     = "" # Set to your node security group ID
}