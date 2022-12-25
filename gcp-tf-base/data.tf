data "google_client_config" "current" {
}

data "google_service_account" "current" {
  email = var.big_robot_email
}
