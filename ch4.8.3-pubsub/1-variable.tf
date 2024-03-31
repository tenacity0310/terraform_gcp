variable "GCP_PROJECT" {
  description = "GCP Project ID"
  type        = string
  default     = "terrafrom101-2024"
}

# name of the topic
variable "topic_name" {
  type    = string
  default = "pubsub-topic-tf-ch-4-8-3"
}

# name of the subscription
variable "subscription_name" {
  type    = string
  default = "pubsub-sub-tf-ch-4-8-3"
}
