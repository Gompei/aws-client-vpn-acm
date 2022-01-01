resource "aws_ec2_client_vpn_endpoint" "client_vpn_endpoint" {
  description            = "example-acm-client-vpn"
  client_cidr_block      = var.vpn_client_cidr_block
  server_certificate_arn = aws_acm_certificate.server.arn

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.root.arn
  }

  connection_log_options {
    enabled = false
  }
}

resource "aws_ec2_client_vpn_authorization_rule" "client_vpn_authorization_rule_1" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client_vpn_endpoint.id
  target_network_cidr    = aws_vpc.vpc.cidr_block
  authorize_all_groups   = true
}

resource "aws_ec2_client_vpn_authorization_rule" "client_vpn_authorization_rule_2" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client_vpn_endpoint.id
  target_network_cidr    = "0.0.0.0/0"
  authorize_all_groups   = true
}

resource "aws_ec2_client_vpn_route" "client_vpn_route" {
  depends_on             = [aws_ec2_client_vpn_network_association.client_vpn_network_association]
  count                  = length(aws_subnet.private)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client_vpn_endpoint.id
  destination_cidr_block = "0.0.0.0/0"
  target_vpc_subnet_id   = aws_subnet.private[count.index].id
}

resource "aws_ec2_client_vpn_network_association" "client_vpn_network_association" {
  count                  = 2
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client_vpn_endpoint.id
  subnet_id              = aws_subnet.private[count.index].id
  security_groups = [
    aws_security_group.vpn_access.id,
    aws_security_group.icmp.id
  ]
}
