
resource "google_storage_bucket" "blobstore" {
  name          = "${var.project}-${var.environment_name}-artifacts"
  force_destroy = true
}

resource "google_service_account" "blobstore" {
  account_id   = "${var.environment_name}-blobstore"
  display_name = "${var.environment_name} Blobstore Service Account"
}

resource "google_service_account_key" "blobstore" {
  service_account_id = google_service_account.blobstore.id
}

resource "google_project_iam_member" "compute-blob-storage-admin" {
  project = var.project
  role    = "roles/compute.storageAdmin"
  member  = "serviceAccount:${google_service_account.blobstore.email}"
}