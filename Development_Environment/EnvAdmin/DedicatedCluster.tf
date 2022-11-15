#This file manages clusters within the current environment
#Each cluster requires a service account to be provided to be mapped to the ClusterAdmin role.
#Also putting Cluster APIKeys in here
resource "confluent_kafka_cluster" "dedicated" {
  display_name = "dedicated_kafka_cluster"
  availability = "MULTI_ZONE"
  cloud        = "AWS"
  region       = "ap-southeast-2"
  dedicated {
    cku = 2
  }
  environment {
    id = data.confluent_environment.current.id
  }
  network {
    id = confluent_network.aws_peered.id
  }

#  lifecycle {
#    prevent_destroy = true
#  }
}

resource "confluent_role_binding" "dedicated-cluster-sa-rb" {
  principal = "User:${data.confluent_service_account.clusteradmin.id}"
  role_name = "CloudClusterAdmin"
  crn_pattern = confluent_kafka_cluster.dedicated.rbac_crn
  #crn_pattern = "crn://confluent.cloud/organization=${var.confluent_cloud_organisation_id}/environment=${data.confluent_environment.current.id}"
}

resource "confluent_api_key" "dedicated-cluster-admin-api-key" {
  display_name = "Dedicated Cluster Admin API key"
  description = "Terraform managed APIKey for cluster admin"
  owner {
    id = data.confluent_service_account.clusteradmin.id
    api_version = data.confluent_service_account.clusteradmin.api_version
    kind = data.confluent_service_account.clusteradmin.kind
  }
  managed_resource {
    id = confluent_kafka_cluster.dedicated.id
    api_version = confluent_kafka_cluster.dedicated.api_version
    kind = confluent_kafka_cluster.dedicated.kind
    environment {
      id = data.confluent_environment.current.id
    }
  }
}

resource "confluent_role_binding" "cluster_sa_rb" {
  principal = "User:${data.confluent_service_account.clusteruser.id}"
  role_name = "CloudClusterAdmin"
  crn_pattern = confluent_kafka_cluster.dedicated.rbac_crn
  #  lifecycle {
  #    prevent_destroy = true
  #  }
}
resource "confluent_api_key" "dedicated-cluster-admin-cloud-api-key" {
  display_name = "Dedicated Cluster Admin CCloud API key"
  description = "Terraform managed APIKey for Cloud cluster admin"
  owner {
    id = data.confluent_service_account.clusteradmin.id
    api_version = data.confluent_service_account.clusteradmin.api_version
    kind = data.confluent_service_account.clusteradmin.kind
  }
}

#resource "confluent_kafka_cluster_config" "dedicated_config" {
#  kafka_cluster {
#    id = confluent_kafka_cluster.dedicated.id
#  }
#  rest_endpoint = confluent_kafka_cluster.dedicated.rest_endpoint
#  config = {
#    "auto.create.topics.enable" = "true"
#    "log.retention.ms" = "604800123"
#  }
#  credentials {
#    key = confluent_api_key.dedicated-cluster-admin-api-key.key
#    secret = confluent_api_key.dedicated-cluster-admin-api-key.secret
#  }
#}

resource "confluent_api_key" "dedicated-cluster-user-api-key" {
  display_name = "Dedicated Cluster User API key"
  description = "Terraform managed APIKey for cluster User"
  owner {
    id = data.confluent_service_account.clusteruser.id
    api_version = data.confluent_service_account.clusteruser.api_version
    kind = data.confluent_service_account.clusteruser.kind
  }
  managed_resource {
    id = confluent_kafka_cluster.dedicated.id
    api_version = confluent_kafka_cluster.dedicated.api_version
    kind = confluent_kafka_cluster.dedicated.kind
    environment {
      id = data.confluent_environment.current.id
    }
  }
}



output "dedicated-cluster" {
  value = confluent_kafka_cluster.dedicated.id
}

output "dedicated-cluster-user-api-key" {
  value = confluent_api_key.dedicated-cluster-user-api-key.id
}

output "dedicated-cluster-user-api-key-secret" {
  value = confluent_api_key.dedicated-cluster-user-api-key.secret
  sensitive = true
}

output "dedicated-cluster-admin-cluster-apikey" {
  value = confluent_api_key.dedicated-cluster-admin-api-key.id
}
output "dedicated-cluster-admin-cluster-apikey-secret" {
  value = confluent_api_key.dedicated-cluster-admin-api-key.secret
  sensitive = true
}

output "dedicated-cluster-admin-cloud-apikey" {
  value = confluent_api_key.dedicated-cluster-admin-cloud-api-key
  sensitive = true
}
#output "dedicated-cluster-admin-cloud-apikey-secret" {
#  value = confluent_api_key.dedicated-cluster-admin-cloud-api-key.secret
#  sensitive = true
#}