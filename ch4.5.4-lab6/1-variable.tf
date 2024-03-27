variable "GCP_PROJECT" {
  description = "GCP Project ID"
  type        = string
  default     = "terrafrom101-2024"
}

variable "gcp_region_lab6" {
  type    = string
  default = "asia-northeast1"
}

# name of the function
variable "func_name_lab6" {
  type    = string
  default = "cloud-function-ch-4-lab6"
}