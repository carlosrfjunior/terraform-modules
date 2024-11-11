module "tagging" {
  source              = "../"
  product             = "aws"
  environment         = "testing"
  owner               = "sre"
  cost_center         = "infrastructure"
  resource            = "tagging"
  data_classification = false
  profile             = var.aws_profile
  region              = var.aws_region
}
