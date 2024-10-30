resource "tls_private_key" "nixos_provisioning" {
  algorithm = "ED25519"
}

resource "tls_private_key" "k3s_server_root" {
  algorithm = "ED25519"
}

resource "tls_private_key" "k3s_agent_1_root" {
  algorithm = "ED25519"
}

resource "tls_private_key" "k3s_agent_2_root" {
  algorithm = "ED25519"
}
