resource "confluent_kafka_topic" "stock_trades" {
  kafka_cluster {
    id = data.confluent_kafka_cluster.current.id
  }
  topic_name = "stock_trades"
  partitions_count = 12
  rest_endpoint = data.confluent_kafka_cluster.current.rest_endpoint
  config = {
    "cleanup.policy" = "delete"
    "retention.ms" = "604800000"
  }
  credentials {
    key = data.terraform_remote_state.EnvAdmin.outputs.dedicated-cluster-admin-cluster-apikey
    secret = data.terraform_remote_state.EnvAdmin.outputs.dedicated-cluster-admin-cluster-apikey-secret
  }
#  lifecycle {
#    prevent_destroy = true
#  }
}
