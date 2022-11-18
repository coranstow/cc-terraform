data "terraform_remote_state" "OrgAdmin" {
  backend = "local"
  config = {
    path = "../OrgAdmin/terraform.tfstate"
  }
}

data "terraform_remote_state" "Org" {
  backend = "local"
  config = {
    path = "../../OrgAdmin/terraform.tfstate"
  }
}

data "confluent_environment" "current" {
  id = data.terraform_remote_state.OrgAdmin.outputs.env
}


data "confluent_service_account" "clusteradmin" {
  id = lookup(data.terraform_remote_state.Org.outputs.ServiceAccounts_apikey, "dev-dedicated-cluster-sa").id
}

data "confluent_service_account" "clusteruser" {
  id = lookup(data.terraform_remote_state.Org.outputs.ServiceAccounts, "dev-dedicated-cluster-user").id
}
