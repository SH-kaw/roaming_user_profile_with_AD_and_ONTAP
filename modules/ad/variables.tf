#ドメイン名
variable "ad_domain_name" {
  description = "ActiveDirectory Domain Name"
  type        = string
}

#NetBios名
variable "ad_netbios_name" {
  description = "ActiveDirectory NetBios Name"
  type        = string
}

#ADのセーフモード用Administratorパスワード
variable "ad_safemode_password" {
  description = "ActiveDirectory Domain safemode Administrator password"
  type        = string
  sensitive   = true
}

#AD用セキュリティグループの許可セグメント
variable "ad_sg_cidr" {
  description = "allow cidr on ipv4 for ActiveDirectory"
  type        = string
}

#踏み台のセキュリティグループにおけるRDP許可
variable "bastion_sg_cidr" {
  description = "allow cidr on ipv4 for Bastion host"
  type        = string
}

#networkモジュールで作成したVPCのID
variable "vpc_id" {
  description = "vpc id by network module"
  type        = string
}

##networkモジュールから呼び出し
#networkモジュールで作成したパブリックサブネットのID
variable "public_subnet_id" {
  description = "public subnet id by network module"
  type        = string
}

#networkモジュールで作成したプライベートサブネットのID
variable "private_subnet_id" {
  description = "private subnet id by network module"
  type        = string
}