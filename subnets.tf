locals {
  management_subnet_cidr = "10.0.0.0/26"
}

resource "google_compute_subnetwork" "management" {
  name          = "${var.environment_name}-management-subnet"
  ip_cidr_range = local.management_subnet_cidr
  network       = google_compute_network.network.self_link
  region        = var.region
}

