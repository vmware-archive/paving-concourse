//create a load balancer for concourse
resource "google_compute_address" "concourse" {
  name = "${var.environment_name}-concourse"
}

resource "google_compute_forwarding_rule" "concourse_credhub" {
  ip_address  = google_compute_address.concourse.address
  ip_protocol = "TCP"
  name        = "${var.environment_name}-concourse-credhub"
  port_range  = "8844-8844"
  target      = google_compute_target_pool.concourse_target_pool.self_link
}

resource "google_compute_forwarding_rule" "concourse_ssh" {
  ip_address  = google_compute_address.concourse.address
  ip_protocol = "TCP"
  name        = "${var.environment_name}-concourse-ssh"
  port_range  = "2222-2222"
  target      = google_compute_target_pool.concourse_target_pool.self_link
}

resource "google_compute_forwarding_rule" "concourse_tcp" {
  ip_address  = google_compute_address.concourse.address
  ip_protocol = "TCP"
  name        = "${var.environment_name}-concourse-tcp"
  port_range  = "443-443"
  target      = google_compute_target_pool.concourse_target_pool.self_link
}

resource "google_compute_forwarding_rule" "concourse_uaa" {
  ip_address  = google_compute_address.concourse.address
  ip_protocol = "TCP"
  name        = "${var.environment_name}-concourse-uaa"
  port_range  = "8443-8443"
  target      = google_compute_target_pool.concourse_target_pool.self_link
}

resource "google_compute_target_pool" "concourse_target_pool" {
  name = "${var.environment_name}-concourse"
}


