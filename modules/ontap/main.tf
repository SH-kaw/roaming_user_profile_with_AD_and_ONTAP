#セキュリティグループ作成
resource "aws_security_group" "ontap_sg" {
  name   = "ontap-sg"
  vpc_id = var.vpc_id
}

##以下で具体的なセキュリティグループのルールを定義
#ICMP
resource "aws_vpc_security_group_ingress_rule" "icmp" {
  security_group_id = aws_security_group.ontap_sg.id
  from_port         = -1
  to_port           = -1
  ip_protocol       = "icmp"
  cidr_ipv4         = var.ontap_sg_cidr
  description       = "ICMP(all)"
}

#SSH
resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.ontap_sg.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = var.ontap_sg_cidr
  description       = "SSH(TCP 22)"
}

#SMB用RPC
resource "aws_vpc_security_group_ingress_rule" "rpc_tcp" {
  security_group_id = aws_security_group.ontap_sg.id
  from_port         = 135
  to_port           = 135
  ip_protocol       = "tcp"
  cidr_ipv4         = var.ontap_sg_cidr
  description       = "RPC Endpoint Mapper(TCP 135)"
}

resource "aws_vpc_security_group_ingress_rule" "rpc_udp" {
  security_group_id = aws_security_group.ontap_sg.id
  from_port         = 135
  to_port           = 135
  ip_protocol       = "udp"
  cidr_ipv4         = var.ontap_sg_cidr
  description       = "RPC Endpoint Mapper(UDP 135)"
}

#SNMP
resource "aws_vpc_security_group_ingress_rule" "snmp_tcp" {
  security_group_id = aws_security_group.ontap_sg.id
  from_port         = 161
  to_port           = 162
  ip_protocol       = "tcp"
  cidr_ipv4         = var.ontap_sg_cidr
  description       = "SNMP(TCP 161-162)"
}

resource "aws_vpc_security_group_ingress_rule" "snmp_udp" {
  security_group_id = aws_security_group.ontap_sg.id
  from_port         = 161
  to_port           = 162
  ip_protocol       = "udp"
  cidr_ipv4         = var.ontap_sg_cidr
  description       = "SNMP(UDP 161-162)"
}

#HTTPS
resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.ontap_sg.id
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = var.ontap_sg_cidr
  description       = "HTTPS(TCP 443)"
}

#SMB
resource "aws_vpc_security_group_ingress_rule" "smb" {
  security_group_id = aws_security_group.ontap_sg.id
  from_port         = 445
  to_port           = 445
  ip_protocol       = "tcp"
  cidr_ipv4         = var.ontap_sg_cidr
  description       = "SMB(TCP 445)"
}

#Kerberos
resource "aws_vpc_security_group_ingress_rule" "Kerberos" {
  security_group_id = aws_security_group.ontap_sg.id
  from_port         = 749
  to_port           = 749
  ip_protocol       = "tcp"
  cidr_ipv4         = var.ontap_sg_cidr 
  description       = "Kerberos admin (TCP 749)"
}

#一時ポート
resource "aws_vpc_security_group_ingress_rule" "ephemeral_ports_tcp" {
  security_group_id = aws_security_group.ontap_sg.id
  from_port         = 1024
  to_port           = 65535
  ip_protocol       = "tcp"
  cidr_ipv4         = var.ontap_sg_cidr
  description       = "Ephemeral TCP ports(TCP 1024-65536)"
}

resource "aws_vpc_security_group_ingress_rule" "ephemeral_ports_udp" {
  security_group_id = aws_security_group.ontap_sg.id
  from_port         = 1024
  to_port           = 65535
  ip_protocol       = "udp"
  cidr_ipv4         = var.ontap_sg_cidr
  description       = "Ephemeral UDP ports(UDP 1024-65536)"
}

#アウトバウンドのトラフィックを全て許可
resource "aws_vpc_security_group_egress_rule" "ontap_allow_all_egress" {
  security_group_id = aws_security_group.ontap_sg.id
  ip_protocol       = "-1"                 
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow all outbound traffic"
}

#FSx for ONTAPを作成
resource "aws_fsx_ontap_file_system" "fsx_ontap" {
  storage_capacity                = var.storage_capacity
  subnet_ids                      = [var.private_subnet_id]
  deployment_type                 = var.deployment_type
  ha_pairs                        = var.ha_pairs
  throughput_capacity_per_ha_pair = var.throughput_capacity
  preferred_subnet_id             = var.private_subnet_id
  fsx_admin_password              = var.fsx_admin_password
  security_group_ids              = [aws_security_group.ontap_sg.id]
}

