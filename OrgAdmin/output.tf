output "Environments" {
  #value = confluentcloud_environment.test-terraform-pre-prod-env.id
  value = { for k, v in confluentcloud_environment.ccloud_environments : k => "ID = ${v.id}, Display Name = ${v.display_name}"}

}

output "ServiceAccounts" {
//  value = confluentcloud_service_account.test-terraform-pre-prod-cluster-sa.id
  value = { for k, v in confluentcloud_service_account.confluent_cloud_service_accounts_list : k => "ID = ${v.id}, Display Name = ${v.display_name}"}

}

output "RoleBindings" {
#  value = confluentcloud_role_binding.test-terraform-pre-prod-env-rb
  value = { for k, v in confluentcloud_role_binding.confluentcloud_role_binding_list : k => "${v.id}, ${v.principal}, ${v.role_name}, ${v.crn_pattern}"}
}