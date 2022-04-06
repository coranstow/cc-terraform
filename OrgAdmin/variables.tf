//Confluent Cloud
variable "confluent_cloud_api_key" {
  description = "API Key"
  default = ""
}
// ssh keys
variable "confluent_cloud_api_secret" {
  description = "Secret for api_key"
  default     = ""
}
variable "confluent_cloud_organisation_id" {
  description = "The ID of the Organisation"
  default     = ""
}

variable "environments" {
  description = "The Environments"
  type  = map(string)
}

variable "service_accounts" {
  description = "Service accounts that need to be defined"
  type = map
}

variable "role_bindings" {
  description = "RoleBindings for Service Accounts"
  type = map
}