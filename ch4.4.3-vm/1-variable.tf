variable "GCP_PROJECT" {
  description = "GCP Project ID"
  type        = string
  default     = "terrafrom101-2024"
}


variable "instance_name" {
  type    = string
  default = "vm-tf-ch4-4-3"
}

# location in Tokyo
variable "location" {
  type    = string
  default = "asia-northeast1"
}

# zone in A zone of tokyo
variable "zone" {
  type    = string
  default = "asia-northeast1-a"
}
