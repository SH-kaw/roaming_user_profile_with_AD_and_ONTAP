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
