resource "aws_vpc_peering_connection" "vpc_peering" {
  for_each    = toset(try(var.vpc_peering_list, []))
  peer_vpc_id = each.key
  vpc_id      = module.vpc.vpc_id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = merge(
    {
      Name = "${var.cluster_name}-vpc-peer"
    }
  )

}
