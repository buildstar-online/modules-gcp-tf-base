terraform {
  backend "gcs" {
    bucket  = "machine-readable-project-name-backend-state-storage"
    prefix  = "terraaform/state"
  }
}
