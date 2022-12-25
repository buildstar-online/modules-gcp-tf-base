# reference our group
data "google_cloud_identity_group" "cloud_identity_group_basic" {
  display_name         = var.big_robot_group
}
