## File that defines the topics for this cluster
## These variables are used in the topics.tf file.

# "topics" variable is a map(topic_name, map(partitions_count, config))

topics = {
  tf-topic1 = {
    partitions_count = 4
    config = {
      "cleanup.policy" = "delete"
      "retention.ms" =  "604800000"
    }
  }
}


kafka_acls = {
#                   [  pattern_type , principal, host, operation, permission ]
  acl1 = ["LITERAL", "User: sa-l56p5n", "*", "DESCRIBE", "ALLOW" ]
  acl2 = ["LITERAL", "User: sa-4jrw2q", "*", "DESCRIBE", "ALLOW" ]


}