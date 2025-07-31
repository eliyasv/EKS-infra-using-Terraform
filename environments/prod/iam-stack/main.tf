# ---------------------------------------
# environments/dev/iam-stack/main.tf
# ---------------------------------------

provider "aws" {
  region = var.infra_region
}

module "iam" {
  source = "../../../modules/iam"

  infra_environment              = var.infra_environment
  infra_project_name             = var.infra_project_name

  infra_create_eks_cluster_role  = var.infra_enable_control_plane_iam
  infra_create_eks_nodegroup_role = var.infra_enable_node_iam_roles
  
  infra_oidc_url                   = module.eks.oidc_issuer_url
  infra_oidc_thumbprint            = data.tls_certificate.oidc_thumbprint.certificates[0].sha1_fingerprint
}
