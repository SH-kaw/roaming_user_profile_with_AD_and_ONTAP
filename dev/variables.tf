##共通

#リージョン 
variable "aws_region" {
  description = "AWS Region Name"
  type        = string
}

#プロファイル 
variable "aws_profile" {
  description = "AWS Profile Name"
  type        = string
}

##adモジュールから呼び出し
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

#ADのセーフモード用Administratorパスワード
variable "ad_safemode_password" {
  description = "ActiveDirectory Domain safemode Administrator password"
  type        = string
  sensitive   = true
}

##networkモジュールから呼び出し
#VPCのセグメント
variable "vpc_cidr_block" {
  description = "vpc cidr block"
  type        = string
}

#パブリックサブネットのセグメント
variable "public_subnet_cidr_block" {
  description = "public subnet cidr block"
  type        = string
}

#プライベートサブネットのセグメント
variable "private_subnet_cidr_block" {
  description = "private subnet cidr block"
  type        = string
}

#サブネットのAZ
variable "subnet_availability_zone" {
  description = "use availability_zone"
  type        = string
}

##ONTAPモジュールから呼び出し
#fsxadminのパスワード
variable "fsx_admin_password" {
  description = "Password for the FSx ONTAP admin account"
  type        = string
  sensitive   = true
}

#ontap用セキュリティグループの許可セグメント
variable "ontap_sg_cidr" {
  description = "allow cidr on ipv4 for FSx ONTAP"
  type        = string
}

#AZの構成
variable "deployment_type" {
  description = "FSx ONTAP deployment_type"
  type        = string
}

#ストレージキャパシティの設定
variable "storage_capacity" {
  description = "FSx ONTAP storage_capacity"
  type        = number
}

#HA-pairの数
variable "ha_pairs" {
  description = "FSx ONTAP ha_pairs"
  type        = number
}

#スループットの設定
variable "throughput_capacity" {
  description = "FSx ONTAP throughput_capacity_per_ha_pair"
  type        = number
}

