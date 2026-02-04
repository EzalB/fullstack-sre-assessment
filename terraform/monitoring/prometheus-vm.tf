resource "google_compute_instance" "prometheus_vm" {
  name         = "prometheus-vm"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["prometheus"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }
  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http-firewall"
  network = default

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0]
  target_tags = ["prometheus"]
}

resource "google_compute_firewall" "deny_metrics" {
  name    = "deny-metrics-firewall"
  network = default

  allow {
    protocol = "tcp"
    ports    = ["9090", "9100"]
  }

  source_ranges = ["0.0.0.0/0]
  target_tags = ["prometheus"]
}


resource "google_compute_network" "default" {
  name = "test-network"
}


resource "google_compute_instance" "node_exporter_vm" {
  name         = "node-exporter-vm"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  tags = ["node-exporter"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }
  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_compute_firewall" "allow_http_node" {
  name    = "allow-node-firewall"
  network = default

  allow {
    protocol = "tcp"
    ports    = ["9100"]
  }

  source_tags = ["prometheus]
  target_tags = ["node-exporter"]
}
