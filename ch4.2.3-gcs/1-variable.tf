variable "GCP_PROJECT" {
  description = "GCP Project ID"
  type        = string
  default     = "terrafrom101-2024"
}


variable "gcs_name" {
  type    = string
  default = "gcs-tf-ch4-2-3-tenacity"

}

variable "location" {
  type    = string
  default = "ASIA"
}