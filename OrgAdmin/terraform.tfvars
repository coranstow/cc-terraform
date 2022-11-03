

## Environment
#environments = {
#  pre-prod-env = "Pre-Production_Terraform_Managed"
#  staging-env = "Staging_Terraform_Managed"
#}

# Service accounts that exist in the envronment
service_accounts = {
  dev-dedicated-cluster-sa = "Terraform Managed Cluster Admin Service Account for Development Environment Dedicated Cluster"
  dev-dedicated-cluster-user = "Terraform Managed Application User Service Account for Development Environment Dedicated Cluster"
}

#role_bindings = {
#  pre-prod-env-sa-env-admin = ["pre-prod-env-sa", "pre-prod-env", "EnvironmentAdmin"]
#  staging-env-sa-env-admin = ["staging-env-sa", "staging-env", "EnvironmentAdmin"]
#}

