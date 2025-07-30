
# ------------------------------------------------
# environments/dev/eks-stack/backend.tf iam-state
# ------------------------------------------------

terraform {
  backend "s3" {
    bucket         = "project-ignite-tfstate" # S3 bucket for state files
    key            = "dev/iam-stack.tfstate"  # Path to the dev-iam state file
    region         = "us-east-1"              # Region for S3 and DynamoDB
    dynamodb_table = "project-ignite-locks"   # DynamoDB table for state locking
    encrypt        = true                     # Enable encryption at rest
  }
}
