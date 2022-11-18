#Outputs that might need to be communicated, eg the IDs os Service accounts.

#output "ServiceAccounts_list" {
#  value = { for k, v in confluent_service_account.confluent_service_accounts_list : k => "ID = ${v.id}, Display Name = ${v.display_name}"}
#}


output "ServiceAccounts" {
  value = confluent_service_account.confluent_service_accounts_list
}

output "ServiceAccounts_apikey" {
  value = confluent_service_account.confluent_service_accounts_apikey_list
}

output "confluent_apikey_service_accounts_list" {
  value = confluent_api_key.confluent_apikey_service_accounts_list
  sensitive = true
}