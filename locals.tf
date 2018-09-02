##########################
#Create local for bastion hostname
##########################

locals {
  bastion_vpc_name  = "${var.bastion_vpc_name == "vpc_id" ? var.vpc : var.bastion_vpc_name}"
  bastion_host_name = "${join("-", compact(list(var.environment_name, data.aws_region.current.name, local.bastion_vpc_name)))}"
}

# Logic tests for security group and listeners 

locals {
  hostport_whitelisted = "${(join(",", var.cidr_blocks_whitelist_host) !="") }"
  hostport_healthcheck = "${(var.lb_healthcheck_port == "2222")}"
}

##########################
# Logic tests for  user-data 
##########################
locals {
  assume_role_yes = "${var.assume_role_arn != "" ? 1 : 0}"
  assume_role_no  = "${var.assume_role_arn == "" ? 1 : 0}"
}

##########################
# Logic tests for  building docker container locally or using custom container
##########################
# locals {
#   custom_container_yes = "${var.custom_container != "" ? 1 : 0}"
#   custom_container_no  = "${var.custom_container == "" ? 1 : 0}"
# }

locals {
  container_build = "${var.custom_container == "" ? "cd /opt/sshd_worker\n        docker build -t sshd_worker ." : var.custom_container}"
}
