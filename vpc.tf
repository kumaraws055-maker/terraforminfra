resource "aws_vpc" "demogitvpc" {
  cidr_block = "10.15.0.0/16"
  enable_dns_hostnames =  true
  tags = {
    "Name" = "DevGitVpc"
  }
  }