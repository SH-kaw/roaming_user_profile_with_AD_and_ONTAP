#adジュール読み込み
module "ad" {
  source = "../modules/ad"

  #networkモジュールから呼び出し
  public_subnet_id     = module.network.public_subnet_id
  private_subnet_id    = module.network.private_subnet_id
  vpc_id               = module.network.vpc_id

  #terraform.tfvarsで定義
  ad_domain_name       = var.ad_domain_name
  ad_netbios_name      = var.ad_netbios_name
  ad_sg_cidr           = var.ad_sg_cidr
  ad_safemode_password = var.ad_safemode_password
  bastion_sg_cidr      = var.bastion_sg_cidr
}

#networkモジュール読み込み
module "network" {
  source = "../modules/network"

  #terraform.tfvarsで定義
  vpc_cidr_block            = var.vpc_cidr_block
  public_subnet_cidr_block  = var.public_subnet_cidr_block
  private_subnet_cidr_block = var.private_subnet_cidr_block
  subnet_availability_zone  = var.subnet_availability_zone
}

#ontapモジュール読み込み
/*
module "ontap" {
  source = "../modules/ontap"

  #networkモジュールから呼び出し
  vpc_id              = module.network.vpc_id
  public_subnet_id    = module.network.public_subnet_id
  private_subnet_id   = module.network.private_subnet_id

  #terraform.tfvarsで定義
  ontap_sg_cidr       = var.ontap_sg_cidr
  fsx_admin_password  = var.fsx_admin_password
  deployment_type     = var.deployment_type
  storage_capacity    = var.storage_capacity
  ha_pairs            = var.ha_pairs
  throughput_capacity = var.throughput_capacity
}
*/