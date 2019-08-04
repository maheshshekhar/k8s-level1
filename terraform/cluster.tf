resource "google_container_cluster" "primary" {
  name               = "mstakx-cluster"
  network            = "default"
  location           = "${var.region}"
  initial_node_count = 1
}