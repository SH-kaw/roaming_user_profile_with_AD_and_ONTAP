#秘密鍵を生成
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

#公開鍵をEC2に登録
resource "aws_key_pair" "generated_key" {
  key_name   = "generated-key"
  public_key = tls_private_key.ec2_key.public_key_openssh
}

#秘密鍵をローカルに出力
resource "local_file" "private_key" {
  content  = tls_private_key.ec2_key.private_key_pem
  filename = "${path.module}/generated-key.pem"
  file_permission = "0400"
}

#セキュリティグループ作成

resource "aws_security_group" "ad_sg" {
  name   = "ad-sg"
  vpc_id = var.vpc_id
}

##以下で具体的なセキュリティグループのルールを定義
# DNS
resource "aws_vpc_security_group_ingress_rule" "dns_tcp" {
  security_group_id = aws_security_group.ad_sg.id
  from_port         = 53
  to_port           = 53
  ip_protocol       = "tcp"
  cidr_ipv4         = var.ad_sg_cidr
  description       = "DNS (TCP 53)"
}

resource "aws_vpc_security_group_ingress_rule" "dns_udp" {
  security_group_id = aws_security_group.ad_sg.id
  from_port         = 53
  to_port           = 53
  ip_protocol       = "udp"
  cidr_ipv4         = var.ad_sg_cidr
  description       = "DNS (UDP 53)"
}

# Kerberos
resource "aws_vpc_security_group_ingress_rule" "kerberos_tcp" {
  security_group_id = aws_security_group.ad_sg.id
  from_port         = 88
  to_port           = 88
  ip_protocol       = "tcp"
  cidr_ipv4         = var.ad_sg_cidr
  description       = "Kerberos (TCP 88)"
}

resource "aws_vpc_security_group_ingress_rule" "kerberos_udp" {
  security_group_id = aws_security_group.ad_sg.id
  from_port         = 88
  to_port           = 88
  ip_protocol       = "udp"
  cidr_ipv4         = var.ad_sg_cidr
  description       = "Kerberos (UDP 88)"
}

# RPC Endpoint Mapper
resource "aws_vpc_security_group_ingress_rule" "rpc_tcp" {
  security_group_id = aws_security_group.ad_sg.id
  from_port         = 135
  to_port           = 135
  ip_protocol       = "tcp"
  cidr_ipv4         = var.ad_sg_cidr
  description       = "RPC Endpoint Mapper (TCP 135)"
}

resource "aws_vpc_security_group_ingress_rule" "rpc_udp" {
  security_group_id = aws_security_group.ad_sg.id
  from_port         = 135
  to_port           = 135
  ip_protocol       = "udp"
  cidr_ipv4         = var.ad_sg_cidr
  description       = "RPC Endpoint Mapper (UDP 135)"
}

# LDAP
resource "aws_vpc_security_group_ingress_rule" "ldap_tcp" {
  security_group_id = aws_security_group.ad_sg.id
  from_port         = 389
  to_port           = 389
  ip_protocol       = "tcp"
  cidr_ipv4         = var.ad_sg_cidr
  description       = "LDAP (TCP 389)"
}

resource "aws_vpc_security_group_ingress_rule" "ldap_udp" {
  security_group_id = aws_security_group.ad_sg.id
  from_port         = 389
  to_port           = 389
  ip_protocol       = "udp"
  cidr_ipv4         = var.ad_sg_cidr
  description       = "LDAP (UDP 389)"
}

# SMB
resource "aws_vpc_security_group_ingress_rule" "smb_tcp" {
  security_group_id = aws_security_group.ad_sg.id
  from_port         = 445
  to_port           = 445
  ip_protocol       = "tcp"
  cidr_ipv4         = var.ad_sg_cidr
  description       = "SMB (TCP 445)"
}

resource "aws_vpc_security_group_ingress_rule" "smb_udp" {
  security_group_id = aws_security_group.ad_sg.id
  from_port         = 445
  to_port           = 445
  ip_protocol       = "udp"
  cidr_ipv4         = var.ad_sg_cidr
  description       = "SMB (UDP 445)"
}

# KPasswd
resource "aws_vpc_security_group_ingress_rule" "KPasswd_tcp" {
  security_group_id = aws_security_group.ad_sg.id
  from_port         = 464
  to_port           = 464
  ip_protocol       = "tcp"
  cidr_ipv4         = var.ad_sg_cidr
  description       = "KPasswd (TCP 464)"
}

resource "aws_vpc_security_group_ingress_rule" "KPasswd_udp" {
  security_group_id = aws_security_group.ad_sg.id
  from_port         = 464
  to_port           = 464
  ip_protocol       = "udp"
  cidr_ipv4         = var.ad_sg_cidr
  description       = "KPasswd (UDP 464)"
}

# Global Catalog
resource "aws_vpc_security_group_ingress_rule" "gc_tcp" {
  security_group_id = aws_security_group.ad_sg.id
  from_port         = 3268
  to_port           = 3268
  ip_protocol       = "tcp"
  cidr_ipv4         = var.ad_sg_cidr
  description       = "Global Catalog (TCP 3268)"
}

# Global Catalog over SSL
resource "aws_vpc_security_group_ingress_rule" "gc_ssl_tcp" {
  security_group_id = aws_security_group.ad_sg.id
  from_port         = 3269
  to_port           = 3269
  ip_protocol       = "tcp"
  cidr_ipv4         = var.ad_sg_cidr
  description       = "Global Catalog SSL (TCP 3269)"
}

#RDP許可(VPC内部用)
resource "aws_vpc_security_group_ingress_rule" "rdp_vpc" {
  security_group_id = aws_security_group.ad_sg.id
  from_port         = 3389
  to_port           = 3389
  ip_protocol       = "tcp"
  cidr_ipv4         = var.ad_sg_cidr
  description       = "Allow RDP (TCP 3389) for vpc"
}

#RDP許可(踏み台用)
resource "aws_vpc_security_group_ingress_rule" "rdp_bastion" {
  security_group_id = aws_security_group.ad_sg.id
  from_port         = 3389
  to_port           = 3389
  ip_protocol       = "tcp"
  cidr_ipv4         = var.bastion_sg_cidr
  description       = "Allow RDP (TCP 3389) for bastion"
}

#ADDSWebサービス
resource "aws_vpc_security_group_ingress_rule" "AD_DS" {
  security_group_id = aws_security_group.ad_sg.id
  from_port         = 9389
  to_port           = 9389
  ip_protocol       = "tcp"
  cidr_ipv4         = var.ad_sg_cidr
  description       = "Allow AD DS Web Service (TCP 9389)"
}

# Dynamic RPC
resource "aws_vpc_security_group_ingress_rule" "dynamic_rpc" {
  security_group_id = aws_security_group.ad_sg.id
  from_port         = 49152
  to_port           = 65535
  ip_protocol       = "tcp"
  cidr_ipv4         = var.ad_sg_cidr
  description       = "Dynamic RPC(TCP 49152_65535)"
}

#アウトバウンドのトラフィックを全て許可
resource "aws_vpc_security_group_egress_rule" "ad_allow_all_egress" {
  security_group_id = aws_security_group.ad_sg.id
  ip_protocol       = "-1"                 
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow all outbound traffic"
}

#WindowsServer2019日本語版の最新のAMI IDを検索
data "aws_ami" "windows_server_ami_id" {
  most_recent = true
  owners      = ["801119661308"] 

  filter {
    name   = "name"
    values = ["Windows_Server-2019-Japanese-Full-Base-*"]
  } 

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

#AD用のEC2を構築
resource "aws_instance" "windows_ad" {
  ami                         = data.aws_ami.windows_server_ami_id.id
  instance_type               = "t3.medium"
  subnet_id                   = var.private_subnet_id
  vpc_security_group_ids      = [aws_security_group.ad_sg.id]
  key_name                    = aws_key_pair.generated_key.key_name
  associate_public_ip_address = false #VPC内からのみアクセスする想定なのでパブリックアドレスなし

  tags = {
    Name = "Windows-AD"
  }

  user_data = <<-EOF
    <powershell>

    # ドメイン情報の設定
    $domainName  = "${var.ad_domain_name}"
    $netbiosName = "${var.ad_netbios_name}"
    $safeModePwd = "${var.ad_safemode_password}" | ConvertTo-SecureString -AsPlainText -Force

    # AD DS, DNS サーバーの役割を追加
    Install-WindowsFeature -Name AD-Domain-Services,DNS -IncludeManagementTools

    # ドメインコントローラーとして昇格（新しいフォレストを作成）
    Install-ADDSForest `
      -DomainName $domainName `
      -DomainNetbiosName $netbiosName `
      -SafeModeAdministratorPassword $safeModePwd `
      -InstallDns `
      -Force:$true

    </powershell>
  EOF
}

#クライアント用のEC2を構築(ドメイン参加などはドメイン構築完了を確認してから別途実施)
resource "aws_instance" "windows_client" {
  ami                         = data.aws_ami.windows_server_ami_id.id
  instance_type               = "t3.medium"
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [aws_security_group.ad_sg.id]
  key_name                    = aws_key_pair.generated_key.key_name
  associate_public_ip_address = true #踏み台としても使う想定でパブリックアドレスを付与する

  tags = {
    Name = "Windows-client"
  }
}


