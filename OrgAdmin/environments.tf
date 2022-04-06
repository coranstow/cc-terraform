


#resource "confluentcloud_environment" "test-terraform-pre-prod-env" {
#  display_name = "Pre-Production_test_terraform"
#}

#resource "confluentcloud_environment" "test-terraform-staging-env" {
#  display_name = "Staging_test_terraform"
#}

resource "confluentcloud_environment" "ccloud_environments" {
  for_each = var.environments
  display_name = each.value

}