resource "google_container_node_pool" "extra-pool" {
  name               = "additional-node-pool"
  zone               = "${var.region}"
  cluster            = "${google_container_cluster.primary.name}"
  initial_node_count = 2
}