This is for resources at an Organization level, but are not related specifically to an environment.
Expect this to be managed by Cloud Ops through some sort of pipeline.

## Requires:
- User Account with OrgAdmin RoleBinding, or
- Service Account with OrgAdmin RoleBinding
    - API Key for that Service Account for the "Cloud" Resource

## Administers
- Service Accounts
- API Keys for Service Accounts that need them for Cloud admin


## Outputs
### OrgAdmin
- ServiceAccounts[] - a list of confluent_service_account resources
- ServiceAccounts_apikey[] - a list of confluent_service_account resources that have an API Key for the Cloud resource
- confluent_apikey_service_accounts_list - a map of API Keys generated for service accounts, keyed on the service account name

There's a distinction between these two types of service accounts
- the service accounts that have an API Key for Cloud have some sort of admin role at Org, Env or CloudCluster level, so we might have to import their API Key/Secret into the Terraform provider at some stage. Only an OrgAdmin can provision an API Key for the Cloud resource.
- the service accounts without an API Key for Cloud will have API Keys for other resources, Cluster, Topic, Schema Registry, etc. API Keys for those resources can be provisioned by OrgAdmin, EnvAdmin or CloudClusterAdmin.