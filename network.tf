locals {
  management_subnet_cidr = "10.0.0.0/26"
}

data "google_dns_managed_zone" "hosted-zone" {
  name = var.hosted_zone
}

resource "google_compute_network" "network" {
  name                    = "${var.environment_name}-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "management" {
  name          = "${var.environment_name}-management-subnet"
  ip_cidr_range = local.management_subnet_cidr
  network       = google_compute_network.network.self_link
  region        = var.region
}

resource "google_compute_firewall" "internal" {
  name    = "${var.environment_name}-internal"
  network = google_compute_network.network.self_link

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  source_ranges = [
    local.management_subnet_cidr,
  ]
}

