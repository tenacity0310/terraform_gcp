variable "GCP_PROJECT" {
  description = "GCP Project ID"
  type        = string
  default     = "terrafrom101-2024"
}

variable "gcp_region" {
  type    = string
  default = "asia-northeast1"
}

# name of the function
variable "container_name" {
  type    = string
  default = "cloud-run-ch-4-6-3"
}