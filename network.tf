# A host project provides network resources to associated service projects.
resource "google_compute_shared_vpc_host_project" "host" {
  project = var.project_id
}

resource "google_compute_network" "network" {
  name                    = "${var.project_id}-network"
  project                 = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "default_subnet" {
  name          = "${var.project_id}-subnet"
  ip_cidr_range = "10.0.0.0/16"
  region        = var.location
  network       = google_compute_network.network.id
}

output "subnet_name" {
  value = google_compute_subnetwork.default_subnet.name
}

output "network_name" {
  value = google_compute_network.network.name
}
