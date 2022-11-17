resource "confluent_connector" "stock_trades_datagen" {
  environment {
    id = data.confluent_environment.current.id
  }
  kafka_cluster {
    id = data.confluent_kafka_cluster.current.id
  }

  config_sensitive = {}

  config_nonsensitive = {
    "connector.class"          = "DatagenSource"
    "name"                     = "DatagenSourceConnector_Stock_Trades"
    "kafka.auth.mode"          = "SERVICE_ACCOUNT"
    "kafka.service.account.id" = data.confluent_service_account.clusteruser.id
    "kafka.topic"              = confluent_kafka_topic.stock_trades.topic_name
    "output.data.format"       = "JSON"
    "quickstart"               = "ORDERS"
    "tasks.max"                = "1"
  }

  depends_on = [
    confluent_kafka_acl.app-connector-describe-on-cluster,
    confluent_kafka_acl.app-connector-write-on-target-topic
#  ,
#    confluent_kafka_acl.app-connector-create-on-data-preview-topics,
#    confluent_kafka_acl.app-connector-write-on-data-preview-topics,
  ]

#  lifecycle {
#    prevent_destroy = true
#  }
}

resource "confluent_kafka_acl" "app-connector-describe-on-cluster" {
  kafka_cluster {
    id = data.confluent_kafka_cluster.current.id
  }
  resource_type = "CLUSTER"
  resource_name = "kafka-cluster"
  pattern_type  = "LITERAL"
  principal     = "User:${data.confluent_service_account.clusteruser.id}"
  host          = "*"
  operation     = "DESCRIBE"
  permission    = "ALLOW"
  rest_endpoint = data.confluent_kafka_cluster.current.rest_endpoint
  credentials {
    key = data.terraform_remote_state.EnvAdmin.outputs.dedicated-cluster-admin-cluster-apikey
    secret = data.terraform_remote_state.EnvAdmin.outputs.dedicated-cluster-admin-cluster-apikey-secret
  }
}

resource "confluent_kafka_acl" "app-connector-write-on-target-topic" {
  kafka_cluster {
    id = data.confluent_kafka_cluster.current.id
  }
  resource_type = "TOPIC"
  resource_name = confluent_kafka_topic.stock_trades.topic_name
  pattern_type  = "LITERAL"
  principal     = "User:${data.confluent_service_account.clusteruser.id}"
  host          = "*"
  operation     = "CREATE"
  permission    = "ALLOW"
  rest_endpoint = data.confluent_kafka_cluster.current.rest_endpoint
  credentials {
    key = data.terraform_remote_state.EnvAdmin.outputs.dedicated-cluster-admin-cluster-apikey
    secret = data.terraform_remote_state.EnvAdmin.outputs.dedicated-cluster-admin-cluster-apikey-secret
  }
}


output "stock-trades-datagen-connector-id" {
  value = confluent_connector.stock_trades_datagen.id
}
