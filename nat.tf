resource "google_compute_address" "nat-address" {
  name   = "${var.environment_name}-cloud-nat"
  region = var.region
}

resource "google_compute_router" "nat-router" {
  name    = "${var.environment_name}-nat-router"
  region  = var.region
  network = google_compute_network.network.self_link

  bgp {
    asn = 64514
  }
}
