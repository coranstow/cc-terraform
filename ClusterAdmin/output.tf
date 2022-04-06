//Template for the Topics in this cluster

output "Topics" {
  #value = confluentcloud_environment.test-terraform-pre-prod-env.id
  value = { for k, v in confluentcloud_kafka_topic.test-terraform-pre-prod-cluster-topic-list : k => "ID = ${v.id}"}

}

