# output section can be used in other terraform files
# output "internal_port" {
#   value = docker_container.nodered_container.ports[0].internal
#   description = "Internal docker port"
#   }

#Splat operator and for loops
# Use the splat expression to assign multiple containers instead of assigning
# container_1 and container_2 individually but this will be in a list.
# splat cannot be used for ip_address output as the output contains too many nested subscripts


# output "container_1" {
#   value = docker_container.nodered_container[0].name
#   description = "Docker container name"
# }

# output "container_2" {
#   value = docker_container.nodered_container[1].name
#   description = "Docker container name"
# }

output "containers" {
  value = docker_container.nodered_container[*].name
  description = "Docker container list"
}

# use for loop instead of resource_ip_address_1 and resource_ip_address_2. Ex below

# > [for cont in docker_container.nodered_container[*] : cont.name]
# [
#   "notered_container-xebg",
#   "notered_container-swl7",
# ]

# output "resource_ip_address_1" {
#   value = join(":", [docker_container.nodered_container[0].network_data[0].ip_address, 
#             docker_container.nodered_container[0].ports[0].internal])
#   description = "IP address of container"
#   sensitive = true
# }

# multiple ip addressed can be used with list below.
# output "resource_ip_address_2" {
#   value = join(":", [docker_container.nodered_container[1].network_data[0].ip_address, 
#             docker_container.nodered_container[1].ports[0].internal])
#   description = "IP address of container"
# }

#looping to get ip addresses/port numbers. Note a list must always be provided to the join function.
#so the splat operator [*] instead of [0] must always be provided to join function so it returns a list.
output "resource_ip_addresses" {
  value = [for cont in docker_container.nodered_container[*] :
             join(":", cont.network_data[*].ip_address, cont.ports[*]["internal"])]
  description = "IP addresses of container"
  sensitive = true
}