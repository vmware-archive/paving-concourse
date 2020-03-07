resource "google_compute_firewall" "ops-manager" {
  name    = "${var.environment_name}-ops-manager"
  network = google_compute_network.network.name

  direction = "INGRESS"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  target_tags = ["${var.environment_name}-ops-manager"]
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

resource "google_compute_firewall" "http-lb" {
  name    = "${var.environment_name}-http-lb-firewall"
  network = google_compute_network.network.self_link

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  target_tags = ["${var.environment_name}-http-lb"]
}

