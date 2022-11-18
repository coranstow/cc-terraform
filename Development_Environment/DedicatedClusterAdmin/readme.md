Configuration of the environment by the Cluster Admin

# Resources
This module will provision:
- a topic called "orders" defined in  Topics.tf
- a Confluent Datagen Source Managed Connector in DatagenConnector.tf
- A Confluent Amazon S3 Sink Managed connector in S3_Sink_Connector.tf

The topic creation is pretty basic.

The Connector config files also include all of the ACLs necessary for that connector to work.

### Secrets
This project has variables aws_key and aws_secret in an auto.tfvars file so that they get imported to the module without being in the main tfvars file. Confluent API keys and secrets are imported from a terraform_remote_state resource.

