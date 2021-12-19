variable "client_id" {}
variable "client_secret" {}

variable "agent_count" {
    default = 2
}

variable "ssh_public_key" {
    default = "~/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
    default = "coursework"
}

variable cluster_name {
    default = "k8s-cluster"
}

variable resource_group_name {
    default = "course_rg"
}

variable location {
    default = "westeurope"
}