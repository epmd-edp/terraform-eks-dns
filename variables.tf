variable "platform_vpc_id" {}

variable "platform_name" {}

variable "create_external_zone" {
  description = "Boolean variable which defines whether external zone will be created or existing will be used"
  default     = false
}

variable "platform_external_subdomain" {
  description = "The name of existing or to be created(depends on create_external_zone variable) external DNS zone"
  default     = ""
}

variable "platform_alb_dns_name" {}

variable "tags" {
  type = map
}
