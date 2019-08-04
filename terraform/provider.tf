provider "google" {
  credentials = "${file("serviceaccount.json")}"
  project     = "${var.project_id}"
  zone        = "asia-south1-a"
}