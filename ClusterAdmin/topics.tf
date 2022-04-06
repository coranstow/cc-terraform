## Template for topics in this cluster

## Topic
resource "confluentcloud_kafka_topic" "test-terraform-pre-prod-cluster-topic-list" {
  for_each = var.topics
  kafka_cluster      = var.confluent_cloud_cluster_id
  topic_name         = each.key
  partitions_count   = each.value["partitions_count"]
  http_endpoint      = var.confluent_cloud_cluster_http_endpoint
  config = each.value["config"]
  credentials {
    key    = var.confluent_cloud_cluster_api_key
    secret = var.confluent_cloud_cluster_api_secret
  }
}

#resource "confluentcloud_kafka_acl" "test-terraform-pre-prod-cluster-topic-acls-list" {
#  for_each = var.kafka_acls
#  kafka_cluster = var.confluent_cloud_cluster_id
#  resource_type = "CLUSTER"
#  resource_name = "kafka-cluster"
#  pattern_type  = each.value[0]
#  principal     = "${each.value[1]}"
##  host          = each.value[2]
#  operation     = each.value[3]
#  permission    = each.value[4]
#  http_endpoint = var.confluent_cloud_cluster_http_endpoint
#  credentials {
#    key    = "<Kafka API Key for confluentcloud_kafka_cluster.basic-cluster>"
#    secret = "<Kafka API Secret for confluentcloud_kafka_cluster.basic-cluster>"
#  }
#}