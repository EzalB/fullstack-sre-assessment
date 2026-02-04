terraform {
  backend "gcs" {
    bucket  = "terraform-state-tidal-airway-485509-d0"
    prefix  = "monitoring/prometheus"
  }
}
