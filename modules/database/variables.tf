#variable "var_region" {
#     default = "europe-north1"
#}

#variable "var_name" {
#     default = "mgdb-tf"
#}
#variable "var_network" {
#  description = "The name or self_link of the network to attach this interface to. Either network or subnetwork must be provided."
 # default     = "default"
#}

#variable "var_subnetwork" {
 # description = "The name or self_link of the subnetwork to attach this interface to. The subnetwork must exist in the same region this instance will be created in. Either network or subnetwork must be provided."
 # default     = ""
#}

#variable "var_subnetwork_project" {
#  description = "The project in which the subnetwork belongs. If the subnetwork is a self_link, this field is ignored in favor of the project defined in the subnetwork self_link. If the subnetwork is a name and this field is not provided, the provider project is used."
 # default     = ""
#}

#variable "var_network_ip" {
#  description = "The private IP address to assign to the instance. If empty, the address will be automatically assigned."
 # default     = ""
#}

#variable "var_nat_ip" {
#    description = "The IP address that will be 1:1 mapped to the instance's network ip. If not given, one will be generated."
#    default     = ""
#}

variable "public_key_path2" {
description = "public key for user isakovasvitlana"
default     = "keys/db/id_dataserver.pub"
#default     = "D:\\dataserver\\id_dataserver.pub"
}

variable "private_key_path2" {
description = "Path to the private key used for ssh access"
  default     = "keys/db/id_dataserver"
#default     = "D:\\dataserver\\id_dataserver"
}
