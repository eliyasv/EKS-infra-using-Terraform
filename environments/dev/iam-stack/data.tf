# ---------------------------------------
# environments/dev/iam-stack/data.tf
# ---------------------------------------

data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket         = "project-ignite-tfstate"
    key            = "dev/eks-stack.tfstate"
    region         = "us-east-1"
    dynamodb_table = "project-ignite-locks"
  }
}

data "tls_certificate" "oidc_thumbprint" {
  url = data.terraform_remote_state.eks.outputs.oidc_issuer_url
}