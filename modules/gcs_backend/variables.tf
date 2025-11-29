variable "bucket_location" {
  description = "The location in which the bucket will be hosted."
  type = string
  default = "US"
}

variable "ran_id_length" {
  description = "Byte length for random ID"
  type        = number
  default     = 8
}

variable "force_destroy" {
  description = "Option for destruction"
  type = string
  default = "false"
}

variable "versioning_enabled" {
  description = "Sets versioning for storage bucket."
  type = bool
  default = true
}

variable "lifecycle_rules" {
  description = "Lifecycle rules for the bucket"
  type = list(object({
    action = string
    age = number
  }))
  default = []
}

variable "generate_backend_file" {
  description = "Whether to generate backend.tf file"
  type = bool
  default = true
}

variable "backend_file_path" {
  description = "Path where backend.tf will be created"
  type = string
  default = ""
}

variable "template_path" {
  description = "A path for the template "
  type = string
}

variable "state_prefix" {
  description = ""
  type = string
}

variable "encryption_key" {
  description = ""
  type = string
  default = ""
  sensitive = true
}
