data "confluent_stream_governance_region" "development" {
  cloud   = "AWS"
  region  = "ap-southeast-2"
  package = "ESSENTIALS"
}

resource "confluent_stream_governance_cluster" "essentials" {
  package = data.confluent_stream_governance_region.development.package

  environment {
    id = data.confluent_environment.current.id
  }

  region {
    # See https://docs.confluent.io/cloud/current/stream-governance/packages.html#stream-governance-regions
    # Stream Governance and Kafka clusters can be in different regions as well as different cloud providers,
    # but you should to place both in the same cloud and region to restrict the fault isolation boundary.
    id = data.confluent_stream_governance_region.development.id
  }

#  lifecycle {
#    prevent_destroy = true
#  }
}

## No documentation yet on how to create a key for the SR
#resource "confluent_api_key" "app-user-schema-api-key" {
#  display_name = "app-user-schema-api-key"
#  description  = "Schema Registry API Key that is owned by 'app-user' service account"
#  owner {
#    id          = data.confluent_service_account.clusteruser.id
#    api_version = data.confluent_service_account.clusteruser.api_version
#    kind        = data.confluent_service_account.clusteruser.kind
#  }
#
#  managed_resource {
#    id            = confluent_stream_governance_cluster.essentials.id
#    api_version   = confluent_stream_governance_cluster.essentials.api_version
#    kind          = confluent_stream_governance_cluster.essentials.kind
##    http_endpoint = confluent_stream_governance_cluster.essentials.http_endpoint
#
#    environment {
#      id = data.confluent_environment.current.id
#    }
#  }
#}