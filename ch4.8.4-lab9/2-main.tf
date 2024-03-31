# Create topic
resource "google_pubsub_topic" "hello_topic_lab9" {
  name = var.topic_name_lab9
}


# Create subscription
resource "google_pubsub_subscription" "hello_subscription_lab9_a" {
  name  = var.subscription_lab9_a
  topic = google_pubsub_topic.hello_topic_lab9.id

  # create filter to link to the expected message 
  filter = "attributes.user = \"a\""
}

# Create subscription
resource "google_pubsub_subscription" "hello_subscription_lab9_b" {
  name  = var.subscription_lab9_b
  topic = google_pubsub_topic.hello_topic_lab9.id

  # create filter to link to the expected message 
  filter = "attributes.user = \"b\""
}


# IAM setting
resource "google_pubsub_topic_iam_member" "hello_topic_iam" {
  topic  = google_pubsub_topic.hello_topic_lab9.name
  role   = "roles/pubsub.publisher"
  member = "allUsers"
}

# output the topic and subscription url
output "topic_url_lab9" {
  value = google_pubsub_topic.hello_topic_lab9.id
}

output "subscription_url_lab9_a" {
  value = google_pubsub_subscription.hello_subscription_lab9_a.id
}

output "subscription_url_lab9_b" {
  value = google_pubsub_subscription.hello_subscription_lab9_b.id
}