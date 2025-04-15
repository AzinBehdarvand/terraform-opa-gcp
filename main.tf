provider "google" {
  project = "training-platform-engineer"
  region  = "europe-west1"
}

resource "google_storage_bucket" "test_invalid" {
  name     = "bucket-invalid-${random_id.bucket1.hex}"
  location = "EU"

  labels = {
    env = "staging"
  }
}

resource "google_storage_bucket" "test_valid" {
  name     = "bucket-valid-${random_id.bucket2.hex}"
  location = "EU"

  labels = {
    env = "dev"
  }
}

resource "random_id" "bucket1" {
  byte_length = 4
}

resource "random_id" "bucket2" {
  byte_length = 4
}