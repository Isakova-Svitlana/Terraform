resource "google_compute_instance" "pd" {
  name         = "${format("%s","${var.var_name}")}"
  machine_type  = "custom-4-8192"
  zone          =   "${format("%s","${var.var_region}-a")}"
  tags          = ["ssh","http","icmp","http-8081","https"]

  boot_disk {
    initialize_params {
      image     =  "debian-9-stretch-v20190905"   
      type = "pd-standard"  
      size = "100"
    }
  }
    
#labels {
#      production_server =  "true"     
 #   }

#metadata {
#        startup-script = <<SCRIPT
#        apt-get -y update
#        apt-get -y install nginx
#        export HOSTNAME=$(hostname | tr -d '\n')
#       export PRIVATE_IP=$(curl -sf -H 'Metadata-Flavor:Google' http://metadata/computeMetadata/v1/instance/network-interfaces/0/ip | tr -d '\n')
#        echo "Welcome to $HOSTNAME - $PRIVATE_IP" > /usr/share/nginx/www/index.html
#        service nginx start
#       SCRIPT
#    } 

metadata = {
   ssh-keys = "isakovasvitlana:${file(var.public_key_path)}"
   
  }

#metadata2 ={
#  ssh-keys = "buildserver:${file(var.public_key_path2)}"
#  }

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