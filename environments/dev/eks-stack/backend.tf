
# -----------------------------------------------
# environments/dev/eks-stack/backend.tf eks-state
# -----------------------------------------------

terraform {
  backend "s3" {
    bucket         = "project-ignite-tfstate" # S3 bucket for state files
    key            = "dev/eks-stack.tfstate"  # Path to the dev-eks state file
    region         = "us-east-1"              # Region for S3 and DynamoDB
    dynamodb_table = "project-ignite-locks"   # DynamoDB table for state locking
    encrypt        = true                     # Enable encryption at rest
  }
}
