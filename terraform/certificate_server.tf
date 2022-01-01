resource "tls_private_key" "server" {
  algorithm = "RSA"
  // default
  rsa_bits = "2048"
}

resource "tls_cert_request" "server" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.server.private_key_pem

  // Set the appropriate value if it should be.
  // This is a test creation, so it's a bit random.
  subject {
    common_name = "example.com"
  }
}

resource "tls_locally_signed_cert" "server" {
  ca_cert_pem           = tls_self_signed_cert.ca.cert_pem
  ca_key_algorithm      = "RSA"
  ca_private_key_pem    = tls_private_key.ca.private_key_pem
  cert_request_pem      = tls_cert_request.server.cert_request_pem
  validity_period_hours = 12

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}
