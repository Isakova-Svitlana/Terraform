resource "google_compute_instance" "pd" {
  name         = "${format("%s","${var.var_name}")}"
  machine_type  = "custom-4-8192"
  zone          =   "${format("%s","${var.var_region}-b")}"
  tags          = ["ssh","http","icmp","http-8081","https"]

  boot_disk {
    initialize_params {
      image     =  "debian-9-stretch-v20190905"   
      type = "pd-standard"  
      size = "100"
    }
  }

metadata = {
   ssh-keys = "isakovasvitlana:${file(var.public_key_path)}"
   
  }

network_interface {
    network            = "${var.var_network}"
    subnetwork         = "${var.var_subnetwork}"
    subnetwork_project = "${var.var_subnetwork_project}"
    network_ip         = "${var.var_network_ip}"

    access_config {
            nat_ip  = "${var.var_nat_ip}"
    }
}
}
resource "null_resource" "pd_prov" {
  
  depends_on = [google_compute_instance.pd]

# connection for the work of service providers after installing and configuring the OS
  connection {
    host        = "${google_compute_instance.pd.network_interface.0.access_config.0.nat_ip}"
    type        = "ssh"
    user        = "isakovasvitlana"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "file" {
    source      = "modules/production/production-tf.sh"
    destination = "/home/isakovasvitlana/production-tf.sh"   
 } 

   provisioner "file" {
    source      = "modules/production/javaexe.sh"
    destination = "/home/isakovasvitlana/javaexe.sh"   
 } 
  
  provisioner "remote-exec" {

    inline = [
      "sudo chmod +x /home/isakovasvitlana/production-tf.sh",
      "sudo /bin/bash /home/isakovasvitlana/production-tf.sh"
    ]
  }
}
