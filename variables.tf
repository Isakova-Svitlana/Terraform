variable "var_project" {
        default = "united-aura-252016"
  }

variable "var_credentials" {
 # description = "CREDENTIALS_JSON_PATH"
 default = "/home/buildagent/keys/united-aura-252016-a5e385393212.json"
 #default = "D:\\keys\\united-aura-252016-a5e385393212.json"
}

variable "var_network_ip" {
  description = "The private IP address to assign to the instance. If empty, the address will be automatically assigned."
  default     = ""
}