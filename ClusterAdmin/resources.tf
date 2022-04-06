locals {

## Topic definitions for the cluster
  # "topics" variable is a map(topic_name, map(partitions_count, config))

  topics = {
    smoketest-topic-1 = {
      partitions_count = 4
      config = {
        "cleanup.policy" = "delete"
        "retention.ms" =  "604800000"
      }
    }
    smoketest-topic-2 = {
      partitions_count = 10
      config = {
        "cleanup.policy" = "delete"
        "retention.ms" =  "604800000"
      }
    }
  }



  # All  ACLs
  # ["UNKNOWN","ANY","ALL","READ","WRITE","CREATE","DELETE","ALTER","DESCRIBE","CLUSTER_ACTION","DESCRIBE_CONFIGS","ALTER_CONFIGS","IDEMPOTENT_WRITE"]

  kafka_cluster_acls = {
    sa-l56p5n = ["ALTER", "DESCRIBE", "ALTER_CONFIGS", "CLUSTER_ACTION", "CREATE", "DESCRIBE_CONFIGS", "IDEMPOTENT_WRITE"]
    sa-4jrw2q = ["ALTER"]
  }
  # All Topic ACLs
  # [ "ALTER", "ALTER_CONFIGS", "CREATE", "DELETE", "DESCRIBE", "DESCRIBE_CONFIGS", "READ", "WRITE" ],
  kafka_topic_acls = {
    sa-l56p5n = {
      smoketest-topic-1 = [ "READ" ]
      smoketest-topic-2 = [ "ALTER", "ALTER_CONFIGS", "CREATE", "DELETE", "DESCRIBE", "DESCRIBE_CONFIGS", "READ", "WRITE" ]
    }
    sa-4jrw2q = {
      smoketest-topic-2 = [ "READ" ]
      smoketest-topic-1 = [ "ALTER", "ALTER_CONFIGS", "CREATE", "DELETE", "DESCRIBE", "DESCRIBE_CONFIGS", "READ", "WRITE" ]
    }
  }


  # --------------------------------------------------------------------------
  # Utility functions, don't modify beyond this point

  # flatten local objects for multiple resources
  data_topics = flatten([for topic, data  in local.topics:
  {
    "topic" = topic,
    "data" = data
  }
  ])

  data_topic_acls = flatten([for user, value in local.kafka_topic_acls:
  flatten([for topic, operations in value:
  [for op in operations:
  {
    "user" = "User:${user}",
    "topic" = topic,
    "op" = op
  }
  ]])
  ])

  data_cluster_acls = flatten([for user, operations in local.kafka_cluster_acls:
  flatten( [for op in operations:
  {
    "user" = "User:${user}",
    "op" = op
  }
  ])
  ])

}