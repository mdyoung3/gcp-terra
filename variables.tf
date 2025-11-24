variable "project_name" {
  description = "The name of the project created in GCP console for this project"
  type        = string
}

variable "gcp_region_1" {
  description = "Sets the desired region"
  type        = string
}

variable "gcp_region_2" {
  description = "Sets the desired region"
  type        = string
}

variable "environment" {
  type        = string
  description = "The environment for deploying (dev, test, prod)"
  default = "dev"
}

variable "ssh_user" {
  description = "SSH username"
  type = string
}

variable "ssh_pub_key_path" {
  description = "path to public ssh key file"
  type = string
}

variable "allowed_ssh_ips" {
  description = "IPs allowed to SSH"
  type = list(string)
}

variable "machine_image" {
  description = "Machine image for project"
  type = string
  default = "ubuntu-os-cloud/ubuntu-2204-lts"
}

variable "ssh_pub_key" {
  description = "SSH Public Key"
  type = string
}
