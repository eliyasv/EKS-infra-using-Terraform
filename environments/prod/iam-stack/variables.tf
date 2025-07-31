# ---------------------------------------
# environments/dev/iam-stack/variables.tf
# ---------------------------------------
variable "infra_environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "infra_project_name" {
  description = "Project name"
  type        = string
}

variable "infra_region" {
  description = "AWS region to deploy infrastructure"
  type        = string
  default     = "us-east-1"
}

variable "infra_create_eks_cluster_role" {
  description = "Flag to create EKS cluster IAM role"
  type        = bool
}

variable "infra_create_eks_nodegroup_role" {
  description = "Flag to create EKS nodegroup IAM role"
  type        = bool
}

variable "infra_enable_control_plane_iam" {
  description = "Whether to create IAM role for EKS control plane"
  type        = bool
  default     = true
}

variable "infra_enable_node_iam_roles" {
  description = "Whether to create IAM roles for EKS node groups"
  type        = bool
  default     = true
}

variable "infra_oidc_url" {
  description = "OIDC provider URL for EKS"
  type        = string
  default     = null
}

variable "infra_oidc_thumbprint" {
  description = "OIDC provider thumbprint"
  type        = string
  default     = null
}
