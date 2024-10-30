variable "proxmox_api_url" {
        type = string
}

variable "proxmox_api_token_id" {
        type = string
        sensitive = true
}

variable "proxmox_api_token_secret" {
        type =  string
        sensitive = true
}

variable "proxmox_target_node" {
        type =  string
}

variable "proxmox_host" {
        type =  string
}

variable "proxmox_ssh_user" {
        type =  string
        sensitive = true
}

variable "proxmox_ssh_password" {
        type =  string
        sensitive = true
}

variable "k3s_token" {
        type =  string
        sensitive = true
}

variable "max_user_public_key" {
        type =  string
}

variable "root_user_password" {
        type =  string
        sensitive = true
}

variable "max_user_password" {
        type =  string
        sensitive = true
}
