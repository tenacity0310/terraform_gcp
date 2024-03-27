variable "GCP_PROJECT" {
  description = "GCP Project ID"
  type        = string
  default     = "terrafrom101-2024"
}


variable "gcs_name" {
  type    = string
  default = "gcs-tf-lab03-tenacity"

}

variable "location" {
  type = string
  # set to one speific region
  default = "asia-east1"
}