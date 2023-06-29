output "rancher_server_url" {
  value = module.rancher_common.rancher_url
}
output "rancher_sslip_io_server_url" {
  value = join(".", ["rancher", aws_instance.rancher_server.public_ip, "sslip.io"])
}


output "rancher_node_ip" {
  value = aws_instance.rancher_server.public_ip
}

output "workload_server_url" {
  value = aws_route53_record.node_server_record.fqdn
}

output "workload_node_ip" {
  value = aws_instance.quickstart_node.public_ip
}
