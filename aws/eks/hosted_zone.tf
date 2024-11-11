locals {
  # Check if it was informed with the parent_dns_name field where the DNS will be derived
  aws_route53_parent = { for k, v in try(var.aws_route53, {}) : k => v if try(v.parent_dns_name, null) != null }
  # Check if the record_dns_names field was informed where the DNS record will be performed in AWS Route 53,
  aws_route53_record = { for k, v in try(var.aws_route53, {}) : k => v if try(v.record_dns_names, null) != null }
  # Lists all domains in the set.
  aws_route53_domains = transpose({ for k, v in try(local.aws_route53_record, {}) : k => try(v.record_dns_names, []) })
  # Lists all parent domains in the set.
  aws_route53_parent_domains = transpose({ for k, v in try(local.aws_route53_parent, {}) : k => try(v.record_dns_names, []) })

  # aws_route53_enabled = try(var.aws_route53, null) == null || length(try(var.aws_route53, {})) < 1 ? false : true
  # aws_route53_count   = length(local.aws_route53_parent) > 0 && local.aws_route53_enabled ? 1 : 0

  ##################################
  # start_region: Certificate filter
  certificates = [for k, v in aws_acm_certificate.cert : v.domain_validation_options]
  domain_validation_options = [for certs in local.certificates : [
    for dvo in certs : {
      domain : dvo.domain_name
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
    ]
  ]
  domain_validation_filter = flatten([for k, v in local.domain_validation_options : v])
  domain_validation_map    = { for i, v in local.domain_validation_filter : v.domain => v }
  # end_region: Certificate filter
  ################################
}
data "aws_route53_zone" "parent" {
  for_each     = local.aws_route53_parent
  provider     = aws.route53
  name         = try(each.value.parent_dns_name, "")
  private_zone = try(each.value.private_zone, true)
}
resource "aws_route53_zone" "child" {
  for_each = local.aws_route53_domains
  name     = try(each.key, null)
  dynamic "vpc" {
    for_each = tobool(data.aws_route53_zone.parent[each.value[0]].private_zone) ? [1] : []
    content {
      vpc_id = module.vpc.vpc_id
    }
  }
}
resource "aws_route53_record" "child_ns" {
  for_each = local.aws_route53_parent_domains

  provider = aws.route53

  zone_id = data.aws_route53_zone.parent[each.value[0]].zone_id
  name    = try(each.key, null)
  type    = "NS"
  ttl     = "30"

  records = aws_route53_zone.child[each.key].name_servers
}

resource "aws_acm_certificate" "cert" {
  for_each          = local.aws_route53_domains
  domain_name       = try(each.key, null)
  validation_method = "DNS"
  subject_alternative_names = [
    format("*.%s", try(each.key, ""))
  ]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_record" {
  for_each = local.domain_validation_map

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.child[replace(each.key, "/\\*\\./", "")].zone_id
}
