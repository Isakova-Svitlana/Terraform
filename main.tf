provider "google" {
  project     = "${var.var_project}"
  credentials = "${var.var_credentials}"
}

resource  "google_compute_instance" "tcbuild"{
    name = "TeamCity-tf"
#provisioner "file" {
#    source      = "D:\\keys\\united-aura-252016-a5e385393212.json"
#    destination = "/home/isakovasvitlana/united-aura-252016-a5e385393212.json"

#  } 

}