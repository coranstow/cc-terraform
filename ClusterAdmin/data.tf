## Environment
#data "confluentcloud_environment" "current_environment" {
#  id = var.confluent_cloud_environment_id
#}

## Cluster
data "confluentcloud_kafka_cluster" "current_cluster" {
  id = var.confluent_cloud_cluster_id
  environment {
    id = var.confluent_cloud_environment_id
  }
}

