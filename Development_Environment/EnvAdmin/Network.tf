#This file creates a network within a confluent environment and some peering connections
resource "confluent_network" "aws_peered" {
#  lifecycle {
#    prevent_destroy = true
#  }
  display_name     = "AWS Peering Network"
  cloud            = "AWS"
  region           = "ap-southeast-2"
  cidr             = "10.253.0.0/16"
  connection_types = ["PEERING"]
  environment {
    id = data.confluent_environment.current.id
  }
}

resource "confluent_peering" "aws-peer-sa" {
  display_name = "AWS Peering Solution Architect"
  aws {
    account           = "492737776546"
    vpc               = "vpc-eb1daf8c"
    routes            = ["172.31.0.0/16"]
    customer_region   = "ap-southeast-2"
  }
  environment {
    id = data.confluent_environment.current.id
  }
  network {
    id = confluent_network.aws_peered.id
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "confluent_peering" "aws-peer-cstow" {
  display_name = "AWS Peering cstow"
  aws {
    account           = "492737776546"
    vpc               = "vpc-0a2a0144ada94ec62"
    routes            = ["192.168.1.0/24"]
    customer_region   = "ap-southeast-2"
  }
  environment {
    id = data.confluent_environment.current.id
  }
  network {
    id = confluent_network.aws_peered.id
  }
  lifecycle {
    prevent_destroy = true
  }
}

output "network" {
  value = confluent_network.aws_peered.id
}