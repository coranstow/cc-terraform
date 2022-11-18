data "terraform_remote_state" "Org" {
  backend = "local"
  config = {
    path = "../../OrgAdmin/terraform.tfstate"
  }
}
data "terraform_remote_state" "OrgAdmin" {
  backend = "local"
  config = {
    path = "../OrgAdmin/terraform.tfstate"
  }
}
data "terraform_remote_state" "EnvAdmin" {
  backend = "local"
  config = {
    path = "../EnvAdmin/terraform.tfstate"
  }
}

data "confluent_environment" "current" {
  id = data.terraform_remote_state.OrgAdmin.outputs.env
}

data "confluent_kafka_cluster" "current" {
  id = data.terraform_remote_state.EnvAdmin.outputs.dedicated-cluster
  environment {
    id = data.terraform_remote_state.OrgAdmin.outputs.env
  }
}

data "confluent_service_account" "clusteradmin" {
  id = data.terraform_remote_state.Org.outputs.ServiceAccounts_apikey["dev-dedicated-cluster-sa"].id
}

data "confluent_service_account" "clusteruser" {
  id = data.terraform_remote_state.Org.outputs.ServiceAccounts["dev-dedicated-cluster-user"].id
}

#data "confluent_api_key" "cloud-api-key" {
#  id = data.terraform_remote_state.Org.outputs.confluent_apikey_service_accounts_list["dev-dedicated-cluster-sa"].id
#}

