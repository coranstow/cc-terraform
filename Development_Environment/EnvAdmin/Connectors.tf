resource "confluent_connector" "pizza_orders_connector" {
  environment {
    id = data.confluent_environment.current.id
  }
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }

  config_sensitive = {}

  config_nonsensitive = {
    "connector.class"          = "DatagenSource"
    "name"                     = "pizza_orders_connector"
    "kafka.auth.mode"          = "SERVICE_ACCOUNT"
    "kafka.service.account.id" = data.confluent_service_account.clusteruser.id
    "kafka.topic"              = confluent_kafka_topic.pizza_orders.topic_name
    "output.data.format"       = "JSON"
    "quickstart"               = "ORDERS"
    "tasks.max"                = "1"
  }

  depends_on = [
    confluent_kafka_acl.app-connector-describe-on-cluster,
    confluent_kafka_acl.app-connector-write-on-target-topic,
    confluent_kafka_acl.app-connector-create-on-data-preview-topics,
    confluent_kafka_acl.app-connector-write-on-data-preview-topics,
  ]

#  lifecycle {
#    prevent_destroy = true
#  }
}

resource "confluent_kafka_acl" "app-connector-describe-on-cluster" {
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }
  resource_type = "CLUSTER"
  resource_name = "kafka-cluster"
  pattern_type  = "LITERAL"
  principal     = "User:${data.confluent_service_account.clusteruser.id}"
  host          = "*"
  operation     = "DESCRIBE"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.dedicated.rest_endpoint
  credentials {
    key    = confluent_api_key.dedicated-cluster-admin-api-key.id
    secret = confluent_api_key.dedicated-cluster-admin-api-key.secret
  }
}
resource "confluent_kafka_acl" "app-connector-write-on-target-topic" {
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }
  resource_type = "TOPIC"
  resource_name = confluent_kafka_topic.pizza_orders.topic_name
  pattern_type  = "LITERAL"
  principal     = "User:${data.confluent_service_account.clusteruser.id}"
  host          = "*"
  operation     = "WRITE"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.dedicated.rest_endpoint
  credentials {
    key    = confluent_api_key.dedicated-cluster-admin-api-key.id
    secret = confluent_api_key.dedicated-cluster-admin-api-key.secret
  }
}
resource "confluent_kafka_acl" "app-connector-create-on-data-preview-topics" {
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }
  resource_type = "TOPIC"
  resource_name = "data-preview"
  pattern_type  = "PREFIXED"
  principal     = "User:${data.confluent_service_account.clusteruser.id}"
  host          = "*"
  operation     = "CREATE"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.dedicated.rest_endpoint
  credentials {
    key    = confluent_api_key.dedicated-cluster-admin-api-key.id
    secret = confluent_api_key.dedicated-cluster-admin-api-key.secret
  }
}
resource "confluent_kafka_acl" "app-connector-write-on-data-preview-topics" {
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }
  resource_type = "TOPIC"
  resource_name = "data-preview"
  pattern_type  = "PREFIXED"
  principal     = "User:${data.confluent_service_account.clusteruser.id}"
  host          = "*"
  operation     = "WRITE"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.dedicated.rest_endpoint
  credentials {
    key    = confluent_api_key.dedicated-cluster-admin-api-key.id
    secret = confluent_api_key.dedicated-cluster-admin-api-key.secret
  }
}

resource "confluent_connector" "aws_s3_sink" {
  environment {
    id = data.confluent_environment.current.id
  }
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }

  config_sensitive = {
    "kafka.api.key"         = "${confluent_api_key.dedicated-cluster-admin-api-key.id}"
    "kafka.api.secret"      = "${confluent_api_key.dedicated-cluster-admin-api-key.secret}"
    "aws.access.key.id"     = "${var.aws_key}"
    "aws.secret.access.key" = "${var.aws_secret}"
  }
  config_nonsensitive = {
    "connector.class"          = "S3_SINK"
    "name"                     = "S3_Sink"
    "kafka.auth.mode"          = "SERVICE_ACCOUNT"
#    "kafka.service.account.id" = data.confluent_service_account.clusteradmin.id
    "tasks.max"                = "1"
    "topics"                   = "${confluent_kafka_topic.pizza_orders.topic_name},${confluent_kafka_topic.stock_trades.topic_name},${confluent_kafka_topic.stock_trades_2.topic_name}"
    "input.data.format"        = "JSON"
    "kafka.auth.mode"          = "KAFKA_API_KEY"
    "s3.bucket.name"           = "cstow-example"
    "output.data.format"       = "JSON"
    "topics.dir"               = "dedicated-cluster"
    "time.interval"            = "HOURLY"
    "flush.size"               = "100"
    "output.keys.format"       = "JSON"
    "output.headers.format"    = "JSON"
    "path.format"              = "YYYY/MM/dd/HH"
  }

  depends_on = [
    confluent_kafka_acl.admin-describe-on-cluster,
    confluent_kafka_acl.admin-create-on-dlq,
    confluent_kafka_acl.admin-write-on-dlq,
#    confluent_kafka_acl.admin-read-on-pizza_orders,
    confluent_kafka_acl.admin-create-on-success,
    confluent_kafka_acl.admin-write-on-success,
    confluent_kafka_acl.admin-create-on-error,
    confluent_kafka_acl.admin-write-on-error,
    confluent_kafka_acl.admin-read-on-connect-cg
  ]

#  lifecycle {
#    prevent_destroy = true
#  }
}

resource "confluent_kafka_acl" "admin-create-on-dlq" {
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }
  resource_type = "TOPIC"
  resource_name = "dlq-lcc"
  pattern_type  = "PREFIXED"
  principal     = "User:${data.confluent_service_account.clusteradmin.id}"
  host          = "*"
  operation     = "CREATE"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.dedicated.rest_endpoint
  credentials {
    key    = confluent_api_key.dedicated-cluster-admin-api-key.id
    secret = confluent_api_key.dedicated-cluster-admin-api-key.secret
  }
}

resource "confluent_kafka_acl" "admin-write-on-dlq" {
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }
  resource_type = "TOPIC"
  resource_name = "dlq-lcc"
  pattern_type  = "PREFIXED"
  principal     = "User:${data.confluent_service_account.clusteradmin.id}"
  host          = "*"
  operation     = "WRITE"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.dedicated.rest_endpoint
  credentials {
    key    = confluent_api_key.dedicated-cluster-admin-api-key.id
    secret = confluent_api_key.dedicated-cluster-admin-api-key.secret
  }
}

resource "confluent_kafka_acl" "admin-describe-on-cluster" {
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }
  resource_type = "CLUSTER"
  resource_name = "kafka-cluster"
  pattern_type  = "LITERAL"
  principal     = "User:${data.confluent_service_account.clusteradmin.id}"
  host          = "*"
  operation     = "DESCRIBE"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.dedicated.rest_endpoint
  credentials {
    key    = confluent_api_key.dedicated-cluster-admin-api-key.id
    secret = confluent_api_key.dedicated-cluster-admin-api-key.secret
  }
}

resource "confluent_kafka_acl" "admin-create-on-success" {
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }
  resource_type = "TOPIC"
  resource_name = "success-lcc"
  pattern_type  = "PREFIXED"
  principal     = "User:${data.confluent_service_account.clusteradmin.id}"
  host          = "*"
  operation     = "CREATE"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.dedicated.rest_endpoint
  credentials {
    key    = confluent_api_key.dedicated-cluster-admin-api-key.id
    secret = confluent_api_key.dedicated-cluster-admin-api-key.secret
  }
}

resource "confluent_kafka_acl" "admin-write-on-success" {
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }
  resource_type = "TOPIC"
  resource_name = "success-lcc"
  pattern_type  = "PREFIXED"
  principal     = "User:${data.confluent_service_account.clusteradmin.id}"
  host          = "*"
  operation     = "WRITE"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.dedicated.rest_endpoint
  credentials {
    key    = confluent_api_key.dedicated-cluster-admin-api-key.id
    secret = confluent_api_key.dedicated-cluster-admin-api-key.secret
  }
}

resource "confluent_kafka_acl" "admin-create-on-error" {
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }
  resource_type = "TOPIC"
  resource_name = "error-lcc"
  pattern_type  = "PREFIXED"
  principal     = "User:${data.confluent_service_account.clusteradmin.id}"
  host          = "*"
  operation     = "CREATE"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.dedicated.rest_endpoint
  credentials {
    key    = confluent_api_key.dedicated-cluster-admin-api-key.id
    secret = confluent_api_key.dedicated-cluster-admin-api-key.secret
  }
}

resource "confluent_kafka_acl" "admin-write-on-error" {
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }
  resource_type = "TOPIC"
  resource_name = "error-lcc"
  pattern_type  = "PREFIXED"
  principal     = "User:${data.confluent_service_account.clusteradmin.id}"
  host          = "*"
  operation     = "WRITE"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.dedicated.rest_endpoint
  credentials {
    key    = confluent_api_key.dedicated-cluster-admin-api-key.id
    secret = confluent_api_key.dedicated-cluster-admin-api-key.secret
  }
}

resource "confluent_kafka_acl" "admin-read-on-connect-cg" {
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }
  resource_type = "GROUP"
  resource_name = "connect-lcc"
  pattern_type  = "PREFIXED"
  principal     = "User:${data.confluent_service_account.clusteradmin.id}"
  host          = "*"
  operation     = "READ"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.dedicated.rest_endpoint
  credentials {
    key    = confluent_api_key.dedicated-cluster-admin-api-key.id
    secret = confluent_api_key.dedicated-cluster-admin-api-key.secret
  }
}

#resource "confluent_kafka_acl" "admin-read-on-pizza_orders" {
#  kafka_cluster {
#    id = confluent_kafka_cluster.dedicated.id
#  }
#  resource_type = "TOPIC"
#  resource_name = "pizza_orders"
#  pattern_type  = "LITERAL"
#  principal     = "User:${data.confluent_service_account.clusteradmin.id}"
#  host          = "*"
#  operation     = "READ"
#  permission    = "ALLOW"
#  rest_endpoint = confluent_kafka_cluster.dedicated.rest_endpoint
#  credentials {
#    key    = confluent_api_key.dedicated-cluster-admin-api-key.id
#    secret = confluent_api_key.dedicated-cluster-admin-api-key.secret
#  }
#}

#resource "confluent_connector" "stock_trades_connector" {
#  environment {
#    id = data.confluent_environment.current.id
#  }
#  kafka_cluster {
#    id = confluent_kafka_cluster.dedicated.id
#  }
#
#  config_sensitive = {}
#
#  config_nonsensitive = {
#    "connector.class"          = "DatagenSource"
#    "name"                     = "stock_trades_connector"
#    "kafka.auth.mode"          = "SERVICE_ACCOUNT"
#    "kafka.service.account.id" = data.confluent_service_account.clusteruser.id
#    "kafka.topic"              = confluent_kafka_topic.stock_trades.topic_name
#    "output.data.format"       = "JSON"
#    "quickstart"               = "STOCK_TRADES"
#    "tasks.max"                = "1"
#  }
#
#  depends_on = [
#    confluent_kafka_acl.app-connector-describe-on-cluster,
#    confluent_kafka_acl.app-connector-write-on-stock_trades-topic,
#    confluent_kafka_acl.app-connector-create-on-data-preview-topics,
#    confluent_kafka_acl.app-connector-write-on-data-preview-topics,
#  ]
#
##  lifecycle {
##    prevent_destroy = true
##  }
#}
resource "confluent_kafka_acl" "app-connector-write-on-stock_trades-topic" {
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }
  resource_type = "TOPIC"
  resource_name = confluent_kafka_topic.stock_trades.topic_name
  pattern_type  = "LITERAL"
  principal     = "User:${data.confluent_service_account.clusteruser.id}"
  host          = "*"
  operation     = "WRITE"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.dedicated.rest_endpoint
  credentials {
    key    = confluent_api_key.dedicated-cluster-admin-api-key.id
    secret = confluent_api_key.dedicated-cluster-admin-api-key.secret
  }
}

#resource "confluent_connector" "stock_trades_connector2" {
#  environment {
#    id = data.confluent_environment.current.id
#  }
#  kafka_cluster {
#    id = confluent_kafka_cluster.dedicated.id
#  }
#
#  config_sensitive = {}
#
#  config_nonsensitive = {
#    "connector.class"          = "DatagenSource"
#    "name"                     = "stock_trades_connector2"
#    "kafka.auth.mode"          = "SERVICE_ACCOUNT"
#    "kafka.service.account.id" = data.confluent_service_account.clusteruser.id
#    "kafka.topic"              = confluent_kafka_topic.stock_trades_2.topic_name
#    "output.data.format"       = "JSON"
#    "quickstart"               = "STOCK_TRADES"
#    "tasks.max"                = "5"
#  }
#
#  depends_on = [
#    confluent_kafka_acl.app-connector-describe-on-cluster,
#    confluent_kafka_acl.app-connector-write-on-stock_trades2-topic,
#    confluent_kafka_acl.app-connector-create-on-data-preview-topics,
#    confluent_kafka_acl.app-connector-write-on-data-preview-topics,
#  ]
#
#  #  lifecycle {
#  #    prevent_destroy = true
#  #  }
#}
#resource "confluent_kafka_acl" "app-connector-write-on-stock_trades2-topic" {
#  kafka_cluster {
#    id = confluent_kafka_cluster.dedicated.id
#  }
#  resource_type = "TOPIC"
#  resource_name = confluent_kafka_topic.stock_trades_2.topic_name
#  pattern_type  = "LITERAL"
#  principal     = "User:${data.confluent_service_account.clusteruser.id}"
#  host          = "*"
#  operation     = "WRITE"
#  permission    = "ALLOW"
#  rest_endpoint = confluent_kafka_cluster.dedicated.rest_endpoint
#  credentials {
#    key    = confluent_api_key.dedicated-cluster-admin-api-key.id
#    secret = confluent_api_key.dedicated-cluster-admin-api-key.secret
#  }
#}