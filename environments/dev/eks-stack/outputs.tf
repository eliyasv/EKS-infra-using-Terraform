output "ignite_cluster_id" {
  value       = try(module.eks.ignite_cluster_id, null)
  description = "ID of the EKS cluster"
}

output "ignite_cluster_name" {
  value       = try(module.eks.ignite_cluster_name, null)
  description = "EKS cluster name"
}

output "ignite_cluster_version" {
  value       = try(module.eks.ignite_cluster_version, null)
  description = "Kubernetes version"
}

output "ignite_cluster_endpoint" {
  value       = try(module.eks.ignite_cluster_endpoint, null)
  description = "EKS cluster endpoint"
}

output "ignite_nodegroup_ondemand_name" {
  value       = try(module.eks.ignite_nodegroup_ondemand_name, null)
  description = "Name of the on-demand node group"
}

output "ignite_nodegroup_spot_name" {
  value       = try(module.eks.ignite_nodegroup_spot_name, null)
  description = "Name of the spot node group"
}

output "oidc_issuer_url" {
  value       = try(module.eks.oidc_issuer_url, null)
  description = "OIDC Issuer URL"
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnet_ids
  description = "Private subnet IDs used by EKS"
}
