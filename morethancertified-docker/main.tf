

resource "docker_image" "nodered_image" {
  //name = "nodered/node-red:latest"
  
  //use lookup based on env. lookup is a map so just supply key and value
  name = lookup(var.image, terraform.workspace)
  //Set to prod - terraform plan -var="env=prod" | grep name
  //Default is dev.
}

resource "docker_container" "nodered_container" {
  count = local.container_count
  name = join("-", ["notered_container", random_string.randomString[count.index].result])
  #name  = "nr-container"
  image = docker_image.nodered_image.image_id
  ports {
    internal = var.internal_port[count.index]
    external = var.external_port[count.index]
  }
  volumes {
    container_path = "/data"
    #host_path = "/home/ec2-user/environment/terraform-docker/noderedvol"
    host_path = "${path.cwd}/noderedvol" //This version uses string interpolation
  }
}

resource "random_string" "randomString" {
  count = local.container_count
  length = 4
  special = false
  upper = false
}

# resource "random_string" "randomString2" {
#   length = 6
#   special = false
#   upper = false
# }
