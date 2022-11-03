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

