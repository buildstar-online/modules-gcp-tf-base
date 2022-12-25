data "google_client_config" "current" {
}

data "google_service_account" "current" {
  var.big_robot_email
}
