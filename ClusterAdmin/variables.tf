//Confluent Cloud
variable "confluent_cloud_api_key" {
  description = "API Key"
  default = ""
}

variable "confluent_cloud_api_secret" {
  description = "Secret for api_key"
  default     = ""
}

variable "confluent_cloud_organisation_id" {
  description = "The ID of the Organisation"
  default     = ""
}

variable "confluent_cloud_environment_id" {
  description = "The ID of the Environment that the Cluster is located in"
  default     = ""
}

variable "confluent_cloud_cluster_id" {
  description = "The ID of the Cluster we are managing topics in"
  default     = ""
}

variable "confluent_cloud_service_account" {
  description = "The Service account with management rights for the cluster"
  default     = ""
}


variable "confluent_cloud_cluster_api_key" {
  description = "The API Key for the Service Account "
  default     = ""
}

variable "confluent_cloud_cluster_api_secret" {
  description = "The secret for the API Key"
  default     = ""
}

variable "confluent_cloud_cluster_http_endpoint" {
  description = "The http endpoint of the cluster"
  type = string
  default = ""
}

variable "topics" {
  description = "Topics that need to be defined"
  type = map
}

variable "kafka_acls" {
  description = "ACLs for topics"
  type = map
}


