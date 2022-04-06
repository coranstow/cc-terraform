## environment RoleBinding for the Service Account
resource "confluentcloud_role_binding" "confluentcloud_role_binding_list" {
  for_each = var.role_bindings
  principal = "User:${confluentcloud_service_account.confluent_cloud_service_accounts_list[each.value[0]].id}"
  role_name = each.value[2]
  crn_pattern = "crn://confluent.cloud/organization=${var.confluent_cloud_organisation_id}/environment=${confluentcloud_environment.ccloud_environments[each.value[1]].id}"
}

