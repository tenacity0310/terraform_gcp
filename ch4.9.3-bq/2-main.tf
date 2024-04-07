# Create big query dataset
resource "google_bigquery_dataset" "example_dataset" {
  dataset_id  = var.bq_name
  description = "Terraform 101 - bq"
  location    = var.gcp_region_bq
}

# Create big query table
resource "google_bigquery_table" "example_table" {
  dataset_id          = google_bigquery_dataset.example_dataset.dataset_id
  table_id            = "example_table"
  deletion_protection = false

  # define the schema
  schema = <<EOF
[
    {
      "name": "name",
      "type": "STRING"
    },
    {
      "name": "age",
      "type": "INTEGER"
    }
]
EOF
}

output "bq_dataset" {
  value = google_bigquery_dataset.example_dataset.dataset_id
}

output "bq_table" {
  value = google_bigquery_table.example_table.table_id
}