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