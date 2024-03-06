# Terraform variables

# This section has been replaced by the addition of terraform workspace
# variable "env" {
#   type = string
#   default = "dev"
#   description = "Env to deploy to"
# }

variable "image" {
  type = map
  description = "Image of container"
  default = {
    dev = "nodered/node-red:latest"
    prod = "nodered/node-red:latest-minimal"
  }
}

variable "external_port" {
  type = list
  #default = 1920
}

variable "internal_port" {
  type = list
  #default = 1880
  sensitive = true
  
# validate a range
  validation {
    condition = max(var.internal_port ...) <= 65535 && min(var.internal_port ...) > 0 //spread operator breaks the list into elements
    error_message = "The internal port must be between 0 and 65535."
  }
}

variable "container_count" {
  type = number
  default = 3
}

#Create a local value to set container_count as number of ports.
#functions cannot be used in the variable construct
locals {
       container_count = length(var.internal_port)
}