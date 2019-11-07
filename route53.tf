resource "aws_route53_zone" "public" {
  count  = var.create_external_zone ? 1 : 0
  name   = var.platform_external_subdomain
  vpc_id = var.platform_vpc_id
  tags   = merge(var.tags, map("Name", "${var.platform_name}-public"))
}

data "aws_route53_zone" "public" {
  count        = ! var.create_external_zone && var.platform_external_subdomain != "" ? 1 : 0
  name         = var.platform_external_subdomain
  private_zone = false
}

resource "aws_route53_record" "public_wildcard" {
  count   = ! var.create_external_zone && var.platform_external_subdomain != "" ? 1 : 0
  zone_id = coalesce(join("", data.aws_route53_zone.public.*.zone_id), join("", aws_route53_zone.public.*.zone_id))
  name    = "*.${var.platform_name}.${var.platform_external_subdomain}"
  type    = "CNAME"
  ttl     = "300"

  records = [
    var.platform_alb_dns_name,
  ]
}
