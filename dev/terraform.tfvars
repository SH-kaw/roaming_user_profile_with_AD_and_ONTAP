#dev用定義
#
aws_region                = "xxxxxxx"
aws_profile               = "xxxxxxx"

#ontap
fsx_admin_password        = "xxxxxxxxx"        #fsx_adminユーザーのパスワードを指定
ontap_sg_cidr             = "xx.xx.xx.xx/xx"   #ONTAPへのアクセスを許可するセグメントを指定
deployment_type           = "xxxxxxxxx"        #ONTAPのAZ設定 SINGLE_AZ_2 だとシングルAZ マルチにしたい場合は MULTI_AZ_2
storage_capacity          = xxxx               #ストレージ容量 最小 1,024 GiB、最大 524,288 GiB (512 TiB)
ha_pairs                  = x                  #デプロイするHA-pairの数 デプロイメントタイプが MULTI_AZ_2 だと 1、SINGLE_AZ_2 だと1から12まで可能
throughput_capacity       = xxx                #ファイルシステムをホストしているファイルサーバーがデータを提供できる持続速度
 
#network
vpc_cidr_block            = "xx.xx.xx.xx/xx"   #VPCのセグメントを指定
public_subnet_cidr_block  = "xx.xx.xx.xx/xx"   #パブリックサブネットのセグメントを指定
private_subnet_cidr_block = "xx.xx.xx.xx/xx"   #プライベートサブネットのセグメントを指定
subnet_availability_zone  = "xxxxxxxxx"        #サブネットのAZを指定

#ad
ad_domain_name            = "xxxxxxxxx"        #ADで構築するドメインの名前を指定
ad_netbios_name           = "xxxx"             #ADで構築するドメインのNetBios名を指定
ad_sg_cidr                = "xx.xx.xx.xx/xx"   #ADへのアクセスを許可するセグメントを指定
ad_safemode_password      = "xxxxxxxxx"        #ADのディレクトリサービス復元モードで使うローカルAdministratorのパスワード
bastion_sg_cidr           = "xx.xx.xx.xx/xx"   #踏み台用Windoes ServerへのRDPを許可するアドレスを設定 
