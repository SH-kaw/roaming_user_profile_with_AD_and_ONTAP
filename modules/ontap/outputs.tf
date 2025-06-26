#ONTAPのIPやホスト名などのエンドポイント情報
output "fsx_endpoints" {
  value       = aws_fsx_ontap_file_system.fsx_ontap.endpoints
  description = "FSx ONTAP endpoint data(IP+DNS)"
}