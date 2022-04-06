//Confluent Cloud
variable "confluent_cloud_api_key" {
  description = "API Key"
  default = ""
}

variable "confluent_cloud_api_secret" {
  description = "Secret for api_key"
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


variable "kafka_api_key" {
  description = "The API Key for the Service Account "
  default     = ""
}

variable "kafka_api_secret" {
  description = "The secret for the API Key"
  default     = ""
}

#variable "topics" {
#  description = "Topics that need to be defined"
#  type = map
#}


#variable "kafka_cluster_acls" {
#  description = "ACLs for the whole clsuter"
#  type = map
#}
#variable "kafka_topic_acls" {
#  description = "ACLs for topics"
#  type = map
#}


