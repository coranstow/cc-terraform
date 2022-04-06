## These IDs are descriptors for the environment this process is operating in.

## Environment
data "confluentcloud_environment" "ccloud_environments" {
  id = var.confluent_cloud_environment_id
}

