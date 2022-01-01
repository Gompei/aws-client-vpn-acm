output "vpn_endpoint_id" {
  value = aws_ec2_client_vpn_endpoint.client_vpn_endpoint.id
}

output "vpn_client_cert" {
  value     = tls_locally_signed_cert.root.cert_pem
  sensitive = true
}

output "vpn_client_key" {
  value     = tls_private_key.root.private_key_pem
  sensitive = true
}
