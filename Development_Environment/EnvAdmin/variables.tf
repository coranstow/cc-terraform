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
variable "aws_key" {
  description = "AWS Key"
  default     = ""
}
variable "aws_secret" {
  description = "The secret for the AWS Key"
  default     = ""
}
