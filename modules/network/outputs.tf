#VPCのID
output "vpc_id" {
  value       = aws_vpc.vpc1.id
  description = "VPC ID"
}

#パブリックサブネットのID
output "public_subnet_id" {
  value       = aws_subnet.public_subnet.id
  description = "Public Subnet ID"
}

#プライベートサブネットのID
output "private_subnet_id" {
  value       = aws_subnet.private_subnet.id
  description = "Private Subnet ID"
}

#パブリック用ルートテーブルのID
output "public_route_table_id" {
  value       = aws_route_table.public_route.id
  description = "Public Route Table ID"
}

#インターネットゲートウェイのID
output "internet_gateway_id" {
  value       = aws_internet_gateway.igw1.id
  description = "Internet Gateway ID"
}
