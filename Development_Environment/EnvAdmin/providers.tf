# Configure the Confluent  Provider
terraform {
  required_providers {

    confluent = {
      source  = "confluentinc/confluent"
      version = "1.14.0"
    }
  }
}

# These are the keys allocated to the Environment Admin
provider "confluent" {
  cloud_api_key    = data.terraform_remote_state.OrgAdmin.outputs.env-sa-apikey    # optionally use CONFLUENT_CLOUD_API_KEY env var
  cloud_api_secret = data.terraform_remote_state.OrgAdmin.outputs.env-sa-apikey-secret # optionally use CONFLUENT_CLOUD_API_SECRET env var
}

