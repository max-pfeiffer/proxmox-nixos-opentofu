# K3s Server
resource "local_file" "k3s_server_user_root_public_key" {
        depends_on = [tls_private_key.k3s_server_root]
        content = tls_private_key.k3s_server_root.public_key_openssh
        filename = "${local.k3s_server_extra_files_ssh_authorized_keys_dir}/root"
}

resource "local_file" "k3s_server_user_max_public_key" {
        content = var.max_user_public_key
        filename = "${local.k3s_server_extra_files_ssh_authorized_keys_dir}/max"
}

resource "local_file" "k3s_server_k3s_token" {
        content = var.k3s_token
        filename = local.k3s_server_extra_files_token_file
}

resource "local_file" "k3s_server_root_user_password_file" {
        content = bcrypt(var.root_user_password)
        filename = "${local.k3s_server_extra_files_passwords_dir}/root"
}

resource "local_file" "k3s_server_max_user_password_file" {
        content = bcrypt(var.max_user_password)
        filename = "${local.k3s_server_extra_files_passwords_dir}/max"
}


# K3s Agent 1
resource "local_file" "k3s_agent_1_user_root_public_key" {
        content = tls_private_key.k3s_agent_1_root.public_key_openssh
        filename = "${local.k3s_agent_1_extra_files_ssh_authorized_keys_dir}/root"
}

resource "local_file" "k3s_agent_1_user_max_public_key" {
        content = var.max_user_public_key
        filename = "${local.k3s_agent_1_extra_files_ssh_authorized_keys_dir}/max"
}

resource "local_file" "k3s_agent_1_k3s_token" {
        content = var.k3s_token
        filename = local.k3s_agent_1_extra_files_token_file
}

resource "local_file" "k3s_agent_1_root_user_password_file" {
        content = bcrypt(var.root_user_password)
        filename = "${local.k3s_agent_1_extra_files_passwords_dir}/root"
}

resource "local_file" "k3s_agent_1_max_user_password_file" {
        content = bcrypt(var.max_user_password)
        filename = "${local.k3s_agent_1_extra_files_passwords_dir}/max"
}


# K3s Agent 2
resource "local_file" "k3s_agent_2_user_root_public_key" {
        content = tls_private_key.k3s_agent_2_root.public_key_openssh
        filename = "${local.k3s_agent_2_extra_files_ssh_authorized_keys_dir}/root"
}

resource "local_file" "k3s_agent_2_user_max_public_key" {
        content = var.max_user_public_key
        filename = "${local.k3s_agent_2_extra_files_ssh_authorized_keys_dir}/max"
}

resource "local_file" "k3s_agent_2_k3s_token" {
        content = var.k3s_token
        filename = local.k3s_agent_2_extra_files_token_file
}

resource "local_file" "k3s_agent_2_root_user_password_file" {
        content = bcrypt(var.root_user_password)
        filename = "${local.k3s_agent_2_extra_files_passwords_dir}/root"
}

resource "local_file" "k3s_agent_2_max_user_password_file" {
        content = bcrypt(var.max_user_password)
        filename = "${local.k3s_agent_2_extra_files_passwords_dir}/max"
}
