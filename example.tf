# Variables must be declared in the file for which they will be used
variable "access_key" {}
variable "secret_key" {}
variable "region" {}

// Configure the Google Cloud provider
provider "google" {
  credentials = "${file("account.json")}"
  project     = "mwp-sandbox-aaa-ers"
  region      = "us-central1"
}

resource "google_storage_bucket" "bucket" {
  name = "test-bucket-terraform-cloud-function"
}

resource "google_storage_bucket_object" "archive" {
  name   = "index.zip"
  bucket = "${google_storage_bucket.bucket.name}"
  source = "./build/index.zip"
}

resource "google_cloudfunctions_function" "function" {
  name                  = "terraform-function-test"
  description           = "My function"
  available_memory_mb   = 128
  source_archive_bucket = "${google_storage_bucket.bucket.name}"
  source_archive_object = "${google_storage_bucket_object.archive.name}"
  # runtime               = "python37"
  trigger_http          = true
  timeout               = 60
  entry_point           = "hello_world"
  labels {
    my-label = "my-label-value"
  }
  environment_variables {
    MY_ENV_VAR = "my-env-var-value"
  }
}