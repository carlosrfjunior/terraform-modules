module "aws_s3_bucket" {
  count = local.velero_bucket_create ? 1 : 0

  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.2"

  bucket = "${var.cluster_name}-velero-backup"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }


  versioning = {
    enabled = true
  }

  tags = var.tags
}
