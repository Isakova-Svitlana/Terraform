provider "google" {
  project     = "${var.var_project}"
  credentials = "${var.var_credentials}"
}

resource "tf-import" "buildserver" "1875925899016644844" {
provisioner "file" {
    source      = "D:\\keys\\united-aura-252016-a5e385393212.json"
    destination = "/home/isakovasvitlana/united-aura-252016-a5e385393212.json"

  } 
provisioner "remote-exec" {
    script = 
}