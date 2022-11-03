#resource "confluent_kafka_cluster" "basic" {
#  display_name = "basic_kafka_cluster"
#  availability = "SINGLE_ZONE"
#  cloud        = "AWS"
#  region       = "ap-southeast-2"
#  basic {}
#
#  environment {
#    id = data.confluent_environment.current.id
#  }
#  lifecycle {
#    prevent_destroy = true
#  }
#}
#
#resource "confluent_api_key" "basic-cluster-admin-api-key" {
#  display_name = "Basic Cluster Admin API key"
#  description = "Terraform managed APIKey for cluster admin"
#  owner {
#    id = data.confluent_service_account.clusteradmin.id
#    api_version = data.confluent_service_account.clusteradmin.api_version
#    kind = data.confluent_service_account.clusteradmin.kind
#  }
#  managed_resource {
#    id = confluent_kafka_cluster.basic.id
#    api_version = confluent_kafka_cluster.basic.api_version
#    kind = confluent_kafka_cluster.basic.kind
#    environment {
#      id = data.confluent_environment.current.id
#    }
#  }
#
#}
#
#output "basic-cluster-api-key" {
#  value = confluent_api_key.basic-cluster-admin-api-key.id
#}
#
#resource "confluent_role_binding" "basic-cluster-rb" {
#  principal = "User:${data.confluent_service_account.clusteradmin.id}"
#  role_name = "CloudClusterAdmin"
#  crn_pattern = confluent_kafka_cluster.basic.rbac_crn
#}
