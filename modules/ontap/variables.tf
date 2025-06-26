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

##networkモジュールから呼び出し
#networkモジュールで作成したVPCのID
variable "vpc_id" {
  description = "vpc id by network module"
  type        = string
}

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
