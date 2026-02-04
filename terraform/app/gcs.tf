resource "google_storage_bucket" "react_app" {
  name          = "react-app-${var.project_id}"
  location      = var.region
  force_destroy = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "index.html"
  }
}

resource "google_storage_bucket_iam_member" "app_public_access" {
  bucket = google_storage_bucket.react_app.name
  role = "roles/storage.objectViewer"
  member = "allUsers"
}