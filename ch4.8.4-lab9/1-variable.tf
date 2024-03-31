variable "GCP_PROJECT" {
  description = "GCP Project ID"
  type        = string
  default     = "terrafrom101-2024"
}

# name of the topic
variable "topic_name_lab9" {
  type    = string
  default = "pubsub-topic-tf-ch4-lab9"
}

# name of the subscription
variable "subscription_lab9_a" {
  type    = string
  default = "pubsub-sub-a-tf-ch4-lab9"
}

variable "subscription_lab9_b" {
  type    = string
  default = "pubsub-sub-b-tf-ch4-lab9"
}