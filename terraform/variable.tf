variable "region" {
    default = "asia-south1-a"
}

variable "gce_key" {
    default = "serviceaccount.json"
}

variable "node_count_zone" {
    default = 1
}

variable "node_pull" {
    default = true
}
variable "project_id" {
  description = "Project ID in GCP"
}