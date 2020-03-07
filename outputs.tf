locals {
  stable_config = {
    environment_name    = var.environment_name
    service_account_key = var.service_account_key
    project             = var.project
    region              = var.region
    availability_zones  = var.availability_zones

    network_name = google_compute_network.network.name

    hosted_zone_name_servers = data.google_dns_managed_zone.hosted-zone.name_servers

    management_subnet_name               = google_compute_subnetwork.management.name
    management_subnet_cidr               = google_compute_subnetwork.management.ip_cidr_range
    management_subnet_gateway            = google_compute_subnetwork.management.gateway_address
    management_subnet_reserved_ip_ranges = "${cidrhost(google_compute_subnetwork.management.ip_cidr_range, 1)}-${cidrhost(google_compute_subnetwork.management.ip_cidr_range, 9)}"

    ops_manager_bucket              = google_storage_bucket.ops-manager.name
    ops_manager_dns                 = replace(google_dns_record_set.ops-manager.name, "/\\.$/", "")
    ops_manager_public_ip           = google_compute_address.ops-manager.address
    ops_manager_service_account_key = base64decode(google_service_account_key.ops-manager.private_key)
    ops_manager_ssh_public_key      = tls_private_key.ops-manager.public_key_openssh
    ops_manager_ssh_private_key     = tls_private_key.ops-manager.private_key_pem
    ops_manager_tags                = "${var.environment_name}-ops-manager"

    platform_vms_tag = "${var.environment_name}-vms"
  }
}

output "stable_config" {
  value     = jsonencode(local.stable_config)
  sensitive = true
}
