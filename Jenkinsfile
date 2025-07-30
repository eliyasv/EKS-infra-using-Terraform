pipeline {
  agent any

  environment {
    TF_VERSION = '1.8.5'
    AWS_REGION = 'us-east-1'
    GIT_REPO   = 'https://github.com/eliyasv/EKS-infra-using-Terraform.git'
    GIT_BRANCH = 'main'
  }

  parameters {
    choice(name: 'ENVIRONMENT', choices: ['dev', 'prod'], description: 'Target environment')
    choice(name: 'ACTION', choices: ['plan', 'apply', 'destroy'], description: 'Terraform action')
  }

  options {
    timestamps()
    disableConcurrentBuilds()
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: "${GIT_BRANCH}", url: "${GIT_REPO}"
      }
    }

    stage('EKS Stack') {
      steps {
        script {
          def eksDir = "environments/${params.ENVIRONMENT}/eks-stack"
          dir(eksDir) {
            withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
              sh "terraform --version"
              sh "terraform init -reconfigure"
              sh 'terraform fmt -recursive'
              sh 'terraform validate'

              if (params.ACTION == "plan" || params.ACTION == "apply") {
                sh "terraform plan -var-file=../${params.ENVIRONMENT}.tfvars -out=tfplan-${params.ENVIRONMENT}-eks"
                if (params.ACTION == "apply") {
                  input message: "Are you sure you want to APPLY changes to ${params.ENVIRONMENT} eks-stack?", ok: "Yes, apply"
                  sh "terraform apply -auto-approve tfplan-${params.ENVIRONMENT}-eks"
                }
              } else if (params.ACTION == "destroy") {
                input message: "WARNING: This will DESTROY eks infra in ${params.ENVIRONMENT}. Proceed?", ok: "Destroy"
                sh "terraform destroy -auto-approve -var-file=../${params.ENVIRONMENT}.tfvars"
              }
            }
          }
        }
      }
    }

    stage('IAM Stack') {
      steps {
        script {
          def iamDir = "environments/${params.ENVIRONMENT}/iam-stack"
          dir(iamDir) {
            withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
              sh "terraform --version"
              sh "terraform init -reconfigure"
              sh 'terraform fmt -recursive'
              sh 'terraform validate'

              if (params.ACTION == "plan" || params.ACTION == "apply") {
                sh "terraform plan -var-file=../${params.ENVIRONMENT}.tfvars -out=tfplan-${params.ENVIRONMENT}-iam"
                if (params.ACTION == "apply") {
                  input message: "Are you sure you want to APPLY changes to ${params.ENVIRONMENT} iam-stack?", ok: "Yes, apply"
                  sh "terraform apply -auto-approve tfplan-${params.ENVIRONMENT}-iam"
                }
              } else if (params.ACTION == "destroy") {
                input message: "WARNING: This will DESTROY IAM infra in ${params.ENVIRONMENT}. Proceed?", ok: "Destroy"
                sh "terraform destroy -auto-approve -var-file=../${params.ENVIRONMENT}.tfvars"
              }
            }
          }
        }
      }
    }
  }

  post {
    success {
      echo " Terraform ${params.ACTION} completed for both eks-stack and iam-stack in ${params.ENVIRONMENT}."
    }
    failure {
      echo " Failure in deploying one or both stacks for ${params.ENVIRONMENT}."
    }
  }
}
