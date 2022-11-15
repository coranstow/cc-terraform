Terraform config for an Environment in Confluent Cloud

Split by Role
- OrgAdmin directory contains the config items that must be provisioned by a service account with OrgAdmin role.
- EnvAdmin directory contains the config items that are provisioned by a service account with EnvAdmin role.
- ClusterAdmin directory contains the config items that are provisioned by a service account with ClusterAdmin role.

The Service Account for Environment Admin is provisioned elsewhere and is a dependency, but api key for that account is managed here.