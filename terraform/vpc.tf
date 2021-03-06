resource "google_compute_network" "vpc" {
  name                    = "vpc"
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}
resource "google_compute_firewall" "allow-internal" {
  name    = "fw-allow-internal"
  network = "${google_compute_network.vpc.name}"

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  target_tags = ["all"]
  source_ranges = [
    "0.0.0.0/0"
  ]
}
resource "google_compute_firewall" "allow-http" {
  name    = "fw-allow-http"
  network = "${google_compute_network.vpc.name}"
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags = ["http"]
}
resource "google_compute_firewall" "allow-bastion" {
  name    = "fw-allow-bastion"
  network = "${google_compute_network.vpc.name}"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["ssh"]
}
