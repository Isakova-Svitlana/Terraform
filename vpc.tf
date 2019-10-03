#resource "google_compute_network" "vpc" {
#  name          =  "default"
#  description  = "Default network for the project"
 # auto_create_subnetworks = "true"
 # routing_mode            = "REGIONAL"
#}

resource "google_compute_firewall" "allow-internal" {
  name    = "fw-allow-internal"
  network = "${var.var_network}"
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  
  target_tags = ["icmp"]

}
resource "google_compute_firewall" "allow-http" {
  name    = "fw-allow-http"
  network = "${var.var_network}"
allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags = ["http"] 
}

resource "google_compute_firewall" "allow-https" {
  name    = "fw-allow-https"
  network = "${var.var_network}"
allow {
    protocol = "tcp"
    ports    = ["443"]
  }
  target_tags = ["https"] 
}
resource "google_compute_firewall" "allow-ssh" {
  name    = "fw-allow-ssh"
  network = "${var.var_network}"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["ssh"]
  }

resource "google_compute_firewall" "allow-http-8081" {
  name    = "fw-allow-http-8081"
  network = "${var.var_network}"
allow {
    protocol = "tcp"
    ports    = ["8081"]
  }
  target_tags = ["http-8081"] 
}

resource "google_compute_firewall" "allow-mgdb-27017" {
  name    = "fw-allow-mgdb-27017"
  network = "${var.var_network}"
allow {
    protocol = "tcp"
    ports    = ["27017"]
  }
  target_tags = ["mgdb-27017"] 
}