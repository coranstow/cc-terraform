variable "environment_vars" {
  description = "The variables"
  type  = map(string)
}



resource "confluent_environment" "environment" {
  display_name = lookup(var.environment_vars, "environment-name")
#  lifecycle {
#    prevent_destroy = true
#  }
}

resource "confluent_service_account" "environment_sa" {
  display_name = lookup(var.environment_vars, "sa-service-account-display-name")
  description = lookup(var.environment_vars, "service-account-description")
#  lifecycle {
#    prevent_destroy = true
#  }
}

resource "confluent_role_binding" "env_sa_rb" {
  principal = "User:${confluent_service_account.environment_sa.id}"
  role_name = "EnvironmentAdmin"
  crn_pattern = "crn://confluent.cloud/organization=${var.confluent_cloud_organisation_id}/environment=${confluent_environment.environment.id}"
#  lifecycle {
#    prevent_destroy = true
#  }
}

resource "confluent_api_key" "env_sa_apikey" {
  display_name = lookup(var.environment_vars, "api-key-display-name")
  description = join("",[lookup(var.environment_vars, "api-key-description"),confluent_service_account.environment_sa.id])
  owner {
    id          = confluent_service_account.environment_sa.id
    api_version = confluent_service_account.environment_sa.api_version
    kind        = confluent_service_account.environment_sa.kind
  }
  depends_on = [ confluent_role_binding.env_sa_rb]
#  lifecycle {
#    prevent_destroy = true
#  }

}


