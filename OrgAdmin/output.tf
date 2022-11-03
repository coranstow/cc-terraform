#output "Environments" {
#  value = { for k, v in confluent_environment.confluent_environments : k => "ID = ${v.id}, Display Name = ${v.display_name}"}
#
#}

output "ServiceAccounts_list" {
  value = { for k, v in confluent_service_account.confluent_service_accounts_list : k => "ID = ${v.id}, Display Name = ${v.display_name}"}
}

output "ServiceAccounts" {
  value = confluent_service_account.confluent_service_accounts_list
}
#output "RoleBindings" {
#  value = { for k, v in confluent_role_binding.confluent_role_binding_list : k => "${v.id}, ${v.principal}, ${v.role_name}, ${v.crn_pattern}"}
#}
