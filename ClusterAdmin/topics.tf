## Template for topics in this cluster

## Topic
resource "confluentcloud_kafka_topic" "test-terraform-pre-prod-cluster-topic-list" {
  for_each = local.topics
  kafka_cluster      = data.confluentcloud_kafka_cluster.current_cluster.id
  topic_name         = each.key
  partitions_count   = each.value["partitions_count"]
  http_endpoint      = data.confluentcloud_kafka_cluster.current_cluster.http_endpoint
  config = each.value["config"]
  credentials {
    key    = var.kafka_api_key
    secret = var.kafka_api_secret
  }
}

resource "confluentcloud_kafka_acl" "cluster_acls" {

  for_each      = { for user, data in local.data_cluster_acls : user => data}

  principal     = each.value.user
  operation     = each.value.op

  pattern_type  = "LITERAL"
  resource_type = "CLUSTER"
  resource_name = "kafka-cluster"
  permission    = "ALLOW"
  host          = "*"
  kafka_cluster = data.confluentcloud_kafka_cluster.current_cluster.id
  http_endpoint = data.confluentcloud_kafka_cluster.current_cluster.http_endpoint
  credentials {
    key    = var.kafka_api_key
    secret = var.kafka_api_secret
  }
}

resource "confluentcloud_kafka_acl" "topic_acls" {

  for_each      =  { for user, data in local.data_topic_acls : user => data }

  principal     = each.value.user

  pattern_type  = "LITERAL"
  resource_type = "TOPIC"
  resource_name = each.value.topic

  operation     = each.value.op
  permission    = "ALLOW"

  host          = "*"
  kafka_cluster = data.confluentcloud_kafka_cluster.current_cluster.id
  http_endpoint = data.confluentcloud_kafka_cluster.current_cluster.http_endpoint
  credentials {
    key    = var.kafka_api_key
    secret = var.kafka_api_secret
  }
}