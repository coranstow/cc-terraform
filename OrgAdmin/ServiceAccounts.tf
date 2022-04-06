

resource "confluentcloud_service_account" "confluent_cloud_service_accounts_list" {
  for_each = var.service_accounts
  display_name = each.key
  description = each.value
}

