variable "var_project" {
        default = "united-aura-252016"
  }

variable "var_credentials" {
 # description = "CREDENTIALS_JSON_PATH"
 default = "/home/buildagent/keys/united-aura-252016-a5e385393212.json"
 #default = "D:\\keys\\united-aura-252016-a5e385393212.json"
}

variable "var_network" {
  description = "The name or self_link of the network to attach this interface to. Either network or subnetwork must be provided."
  default     = "default"
}
