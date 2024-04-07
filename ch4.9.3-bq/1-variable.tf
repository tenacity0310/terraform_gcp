variable "GCP_PROJECT" {
  description = "GCP Project ID"
  type        = string
  default     = "terrafrom101-2024"
}

# specify region
variable "gcp_region_bq" {
  type    = string
  default = "asia-northeast1"
}

#specify zone
variable "gcp_zone_bq" {
  type    = string
  default = "asia-northeast1-a"
}

# specify big query name
variable "bq_name" {
  type    = string
  default = "bq_tf_ch4_9_3"
}




