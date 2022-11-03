#REMMED OUT - defer to individual environment projects managed by the orgadmin
#resource "confluent_environment" "confluent_environments" {
#  for_each = var.environments
#  display_name = each.value
#}