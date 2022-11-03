#resource "confluent_kafka_cluster" "standard" {
#  display_name = "standard_kafka_cluster"
#  availability = "SINGLE_ZONE"
#  cloud        = "AWS"
#  region       = "ap-southeast-2"
#  standard {}
#  environment {
#    id = data.confluent_environment.current.id
#  }
#
#  lifecycle {
#    prevent_destroy = true
#  }
#}
#
#resource "confluent_api_key" "standard-cluster-admin-api-key" {
#  display_name = "Standard Cluster Admin API key"
#  description = "Terraform managed APIKey for cluster admin"
#  owner {
#    id = data.confluent_service_account.clusteradmin.id
#    api_version = data.confluent_service_account.clusteradmin.api_version
#    kind = data.confluent_service_account.clusteradmin.kind
#  }
#  managed_resource {
#    id = confluent_kafka_cluster.standard.id
#    api_version = confluent_kafka_cluster.standard.api_version
#    kind = confluent_kafka_cluster.standard.kind
#    environment {
#      id = data.confluent_environment.current.id
#    }
#  }
#}
#
#output "standard-cluster-api-key" {
#  value = confluent_api_key.standard-cluster-admin-api-key.id
#}
#
#resource "confluent_role_binding" "standard-cluster-rb" {
#  principal = "User:${data.confluent_service_account.clusteradmin.id}"
#  role_name = "CloudClusterAdmin"
#  crn_pattern = confluent_kafka_cluster.standard.rbac_crn
#}
