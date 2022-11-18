# Configure the Confluent  Provider
terraform {
  required_providers {

    confluent = {
      source  = "confluentinc/confluent"
      version = "1.14.0"
    }
  }
}

provider "confluent" {
  cloud_api_key       = data.terraform_remote_state.Org.outputs.confluent_apikey_service_accounts_list["dev-dedicated-cluster-sa"].id
  cloud_api_secret    = data.terraform_remote_state.Org.outputs.confluent_apikey_service_accounts_list["dev-dedicated-cluster-sa"].secret

}

