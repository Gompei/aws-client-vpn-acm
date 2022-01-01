resource "tls_private_key" "ca" {
  algorithm = "RSA"
  // default
  rsa_bits = "2048"
}

resource "tls_self_signed_cert" "ca" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.ca.private_key_pem

  // Set the appropriate value if it should be.
  // This is a test creation, so it's a bit random.
  subject {
    common_name = "example.com"
  }

  validity_period_hours = 12

  allowed_uses = [
    "cert_signing",
    "crl_signing",
  ]
}
