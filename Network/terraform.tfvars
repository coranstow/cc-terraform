region = "ap-southeast-2"
vpc_id = "vpc-eb1daf8c"
privatelink_service_name = "com.amazonaws.vpce.ap-southeast-2.vpce-svc-0fcd764a6ff13dbd8"
bootstrap = "lkc-mvpv71-gjrm96.ap-southeast-2.aws.glb.confluent.cloud:9092"
subnets_to_privatelink = {
  "apse2-az1" = "subnet-05017362",
  "apse2-az2" = "subnet-eb48bab3",
  "apse2-az3" = "subnet-86a6cacf",
}
