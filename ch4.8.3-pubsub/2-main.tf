# Create topic
resource "google_pubsub_topic" "hello_topic" {
  name = var.topic_name
}


# Create subscription
resource "google_pubsub_subscription" "hello_subscription" {
  name  = var.subscription_name
  topic = google_pubsub_topic.hello_topic.id
}

# IAM setting
resource "google_pubsub_topic_iam_member" "hello_topic_iam" {
  topic  = google_pubsub_topic.hello_topic.name
  role   = "roles/pubsub.publisher"
  member = "allUsers"
}

# output the topic and subscription url
output "topic_url" {
  value = google_pubsub_topic.hello_topic.id
}

output "subscription_url" {
  value = google_pubsub_subscription.hello_subscription.id
}