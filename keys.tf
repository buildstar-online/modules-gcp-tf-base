# Create a keyring
data "google_kms_key_ring" "keyring" {
  name     = var.keyring
  location = var.location
}

# add a key to the keyring
resource "random_string" "random-key-name" {
  length           = 16
  special          = false
}

resource "google_kms_crypto_key" "key" {
  name            = random_string.random-key-name.result
  key_ring        = data.google_kms_key_ring.keyring.id
  rotation_period = "100000s"
}

data "google_cloud_identity_groups" "cloud_identity_group_basic" {
  parent = "identitysources/${var.organization}"
}

# Give our service accout we created in iam.tf access to the keyring
data "google_iam_policy" "keyEditor" {
  binding {
    role = "roles/editor"

    members = [
      "group:${var.big_robot_group}",
    ]
  }
}

# Create a service account key
resource "google_service_account_key" "mykey" {
  service_account_id = data.google_service_account.current.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

# add policy for keyring from we crated in iam.tf
resource "google_kms_key_ring_iam_policy" "key_ring_policy" {
  key_ring_id = data.google_kms_key_ring.keyring.id
  policy_data = data.google_iam_policy.keyEditor.policy_data
}

output "service_account_key_id" {
  value = google_service_account_key.mykey.id
}

output "google_kms_crypto_key_id" {
  value = google_kms_crypto_key.key.id
}
