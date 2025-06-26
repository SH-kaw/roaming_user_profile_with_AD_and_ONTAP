#VPC
resource "aws_vpc" "vpc1" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "ontap_vpc"
  }
}

#パブリックサブネット用のインターネットゲートウェイ
resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "ontap-igw"
  }
}

#パブリックサブネット
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.public_subnet_cidr_block
  availability_zone = var.subnet_availability_zone
  map_public_ip_on_launch = true #サブネット内のインスタンスにパブリックIPが付与される

    tags = {
    Name = "ontap-subnet1"
  }
}

#プライベートサブネット
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.private_subnet_cidr_block
  availability_zone = var.subnet_availability_zone

    tags = {
    Name = "ontap-subnet2"
  }
}

#パブリックサブネット用のルートテーブル
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }

  tags = {
    Name = "ontap_public_route"
  }
}

#プライベートサブネット用のルートテーブル
resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "ontap_private_route"
  }
}

#各subnetと各ルートテーブルの関連付け
resource "aws_route_table_association" "public_route_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "private_route_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route.id
}

