output "db_external_ip" {
  value = "${google_compute_instance.pd.network_interface.0.access_config.0.nat_ip}"
}

output "db_internal_ip" {
  value = "${google_compute_instance.pd.network_interface.0.network_ip}"
}
