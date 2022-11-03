## environment RoleBinding for the Service Account
#Remmed out - allow resoruce owners to dertermine rolebindings
#resource "confluent_role_binding" "confluent_role_binding_list" {
#  for_each = var.role_bindings
#  principal = "User:${confluent_service_account.confluent_service_accounts_list[each.value[0]].id}"
#  role_name = each.value[2]
#  crn_pattern = "crn://confluent.cloud/organization=${var.confluent_cloud_organisation_id}/environment=${confluent_environment.confluent_environments[each.value[1]].id}"
#}

