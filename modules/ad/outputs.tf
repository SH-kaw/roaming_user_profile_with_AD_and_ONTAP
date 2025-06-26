#AD用セキュリティグループのIDを出力
output "ad_security_group_id" {
  value       = aws_security_group.ad_sg.id
  description = "Security Group ID for FSx ONTAP"
}
