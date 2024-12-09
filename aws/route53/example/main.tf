locals {
  tags = {
    company_name          = "MyCompany"
    application_id        = "WebApplicationsX"
    business_unit_id      = "DevOps"
    cost_center           = "Infrastructure"
    owner                 = "Operations"
    layer_id              = "Web_Layer"
    environment_id        = "Test"
    operations_owner      = "Squad01"
    disaster_recovery_rpo = ""
    data_classification   = "Restricted"
    compliance_framework  = ""
  }
}

module "route53_domains" {
  source = "../"

  profile = "testing"
  region  = "us-east-1"

  aws_route53 = {

    meudominio_com = {
      private_zone = true
      # vpc_id           = ""
      record_dns_names = ["dev-meudominio.com"]
    }

  }

  tags = local.tags

}
