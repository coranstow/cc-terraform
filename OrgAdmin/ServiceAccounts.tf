

resource "confluent_service_account" "confluent_service_accounts_list" {
  for_each = var.service_accounts
  display_name = each.key
  description = each.value
}

resource "confluent_service_account" "confluent_service_accounts_apikey_list" {
  for_each = var.service_accounts_apikey
  display_name = each.key
  description = each.value
}

resource "confluent_api_key" "confluent_apikey_service_accounts_list" {
  for_each = confluent_service_account.confluent_service_accounts_apikey_list

  display_name = "${confluent_service_account.confluent_service_accounts_apikey_list[each.key].display_name}-api-key"
  description  = "Cloud API Key that is owned by service account ${confluent_service_account.confluent_service_accounts_apikey_list[each.key].display_name}"
  owner {
    id          = confluent_service_account.confluent_service_accounts_apikey_list[each.key].id
    api_version = confluent_service_account.confluent_service_accounts_apikey_list[each.key].api_version
    kind        = confluent_service_account.confluent_service_accounts_apikey_list[each.key].kind
  }
#  lifecycle {
#    prevent_destroy = true
#  }
}

