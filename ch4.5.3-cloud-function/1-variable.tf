variable "GCP_PROJECT" {
  description = "GCP Project ID"
  type        = string
  default     = "terrafrom101-2024"
}

variable "gcp_region" {
  type    = string
  default = "asia-east1"
}

# name of the function
variable "func_name" {
  type    = string
  default = "cloud-function-ch-4-5-3"
}