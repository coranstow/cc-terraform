

## Environment
environments = {
  test-terraform-pre-prod-env = "Pre-Production_test_terraform"
  test-terraform-staging-env = "Staging_test_terraform"
}

service_accounts = {
  test-terraform-pre-prod-env-sa = "Service Account for Coran's Terraform Environment/Cluster testing."
  test-terraform-pre-prod-cluster-sa = "Service Account for Coran's Terraform Environment/Cluster testing."
  test-terraform-pre-prod-cluster-user = "Service Account for Coran's Terraform Environment/Cluster testing."
  test-terraform-staging-env-sa = "Service Account for Coran's Terraform Environment/Cluster testing."
  test-terraform-staging-cluster-sa = "Service Account for Coran's Terraform Environment/Cluster testing."
  test-terraform-staging-cluster-user = "Service Account for Coran's Terraform Environment/Cluster testing."
}

role_bindings = {
  test-terraform-pre-prod-env-sa-env-admin = ["test-terraform-pre-prod-env-sa", "test-terraform-pre-prod-env", "EnvironmentAdmin"]
  test-terraform-staging-env-sa-env-admin = ["test-terraform-staging-env-sa", "test-terraform-staging-env", "EnvironmentAdmin"]
}