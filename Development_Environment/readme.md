Terraform config for an Environment in Confluent Cloud

Split by Role to demonstrate actions by least privileged account
- OrgAdmin directory contains the config items that must be provisioned by a service account with OrgAdmin role.
  - Environment
  - Service Account for the Environment Admin
  - EnvAdmin RoleBinding for the designated environment admin service account
  - API Key and Secret for the environment admin
- EnvAdmin directory contains the config items that are provisioned by a service account with EnvAdmin role.
- ClusterAdmin directory contains the config items that are provisioned by a service account with ClusterAdmin role.

The Service Account for Environment Admin is provisioned elsewhere and is a dependency, but api key for that account is managed here.

## Outputs
### OrgAdmin
- env - The Environment ID supplied by Confluent
- env-sa - The ID of the service account that was granted EnvAdmin RoleBinding to the environment
- env-sa-apikey - The Cloud API Key of the service account
- env-sa-apikey-secret - The secret for the Cloud API Key of the service account

### EnvAdmin
- dedicated-cluster - The ID of a dedicated cluster that has been created.
- dedicated-cluster-admin-cluster-apikey - A Cluster API Key generated for the Cluster's designated admin
- dedicated-cluster-admin-cluster-apikey-secret - the Secret for the administrator's AP Key
- dedicated-cluster-user-api-key - A Cluster API Key generated for a designated cluster user
- dedicated-cluster-user-api-key-secret - the Secret for the administrator's API Key
- network - A Confluent Cloud network that was provisioned for this environment

### CloudClusterAdmin
- orders-topic = the name of a topic
- s3-sink-connector-id - the Confluent Cloud ID of the S3 sink connector
- orders-datagen-connector-id - the Confluent Cloud ID of the Datagen source connector