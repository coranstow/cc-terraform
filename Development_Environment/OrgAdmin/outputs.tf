output "env" {
  value = confluent_environment.environment.id
}

output "env-sa" {
  value = confluent_service_account.environment_sa.id
}

output "env-sa-apikey" {
  value = confluent_api_key.env_sa_apikey.id
}
output "env-sa-apikey-secret" {
  value = confluent_api_key.env_sa_apikey.secret
  sensitive = true
}

