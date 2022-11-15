# Terraform -managed service accounts.
# Have to be set at the Org level because they can only be provisioned by an OrgAdmin.
# Service Accounts that are solely for Environment Admin provisioned with the environment
service_accounts = {
  dev-dedicated-cluster-user = "Terraform Managed Application User Service Account for Development Environment Dedicated Cluster"
  dev-dedicated-cluster-s3Conn = "Terraform Managed Application  Service Account for Development Environment Dedicated Cluster S3 Sink connector"
}

service_accounts_apikey = {
  dev-dedicated-cluster-sa = "Terraform Managed Cluster Admin Service Account for Development Environment Dedicated Cluster"
}