resource "confluent_kafka_topic" "pizza_orders" {
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }
  topic_name = "pizza_orders"
  partitions_count = 12
  rest_endpoint = confluent_kafka_cluster.dedicated.rest_endpoint
  config = {
    "cleanup.policy" = "delete"
    "retention.ms" = "604800000"
  }
  credentials {
    key = confluent_api_key.dedicated-cluster-admin-api-key.id
    secret = confluent_api_key.dedicated-cluster-admin-api-key.secret
  }
#  lifecycle {
#    prevent_destroy = true
#  }
}

resource "confluent_kafka_topic" "stock_trades" {
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }
  topic_name = "stock_trades"
  partitions_count = 12
  rest_endpoint = confluent_kafka_cluster.dedicated.rest_endpoint
  config = {
    "cleanup.policy" = "delete"
    "retention.ms" = "604800000"
  }
  credentials {
    key = confluent_api_key.dedicated-cluster-admin-api-key.id
    secret = confluent_api_key.dedicated-cluster-admin-api-key.secret
  }
#  lifecycle {
#    prevent_destroy = true
#  }
}

resource "confluent_kafka_topic" "stock_trades_2" {
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }
  topic_name = "stock_trades_2"
  partitions_count = 12
  rest_endpoint = confluent_kafka_cluster.dedicated.rest_endpoint
  config = {
    "cleanup.policy" = "delete"
    "retention.ms" = "604800000"
  }
  credentials {
    key = confluent_api_key.dedicated-cluster-admin-api-key.id
    secret = confluent_api_key.dedicated-cluster-admin-api-key.secret
  }
#  lifecycle {
#    prevent_destroy = true
#  }
}