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

  tags = {
    product             = "aws"
    environment         = "testing"
    owner               = "sre"
    cost_center         = "infrastructure"
    resource            = "route53"
    data_classification = "false"
  }

}
