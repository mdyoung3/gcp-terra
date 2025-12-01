variable "project_name" {
  description = "The name of the project created in GCP console for this project"
  type        = string
}

variable "gcp_region_1" {
  description = "Sets the desired region."
  type        = string
}

variable "gcp_region_2" {
  description = "Sets the desired region."
  type        = string
}
variable "gcp_zone_1" {
  description = "Sets the desired zone."
  type        = string
}

variable "gcp_zone_2" {
  description = "Sets the desired zone."
  type        = string
}

variable "machine_image" {
  description = "Machine image for project"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2204-lts"
}

variable "ssh_ip_ranges" {
  description = "Shares a range of IPs for accessing the server via ssh."
  type = list(string)
}
