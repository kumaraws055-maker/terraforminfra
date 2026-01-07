resource "aws_vpc" "demogitvpc" {
  cidr_block = "10.15.0.0/16"
  enable_dns_hostnames =  true
  tags = {
    "Name" = "DevGitVpc"
  }
  }

  resource "aws_subnet" "demogitsubnet-1" {
    vpc_id = aws_vpc.demogitvpc.id
    cidr_block = "10.15.1.0/24"
    availability_zone = "ap-south-1a"
    tags = {
      "Name" = "DevGitSubnet-1"
    }
  }