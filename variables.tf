variable "ingress_inbound_http" {
  type        = string
  description = "Sets port(s) for incoming connections"
}

variable "instance_type" {
  type        = string
  description = "Sets the instance for this resource"
}

variable "company_name" {
  type        = string
  description = "Name of the company"
  default     = "jellobelt"
}

variable "project" {
  type        = string
  description = "The name of the project"
}

variable "environment" {
  type        = string
  description = "The environment for deploying (dev, test, prod)"
}

variable "billing_code" {
  type        = string
  description = "The billing code of the project"
}

variable "protocol" {
  type        = string
  description = "The protocol (http or https) the resource can connect to"
  default     = "http"
}
