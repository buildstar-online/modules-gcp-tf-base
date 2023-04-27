# GCP TF Base module

Requires an existing `project`, `service account` as demonstrated in [gcp-tf-starter](https://github.com/cloudymax/gcp-tf-starter)

This module adds the following to your existing project:
- Storage Bucket
- KMS key assigned to a Service Account
- Top-Level Network and Subnet

## Usage

See it in action at https://github.com/cloudymax/gcp-tf-starter

```hcl
module "gcp-tf-base" {

  source = "github.com/cloudymax/modules-gcp-tf-base.git"

  organization    = var.organization
  organization_id = var.organization_id
  billing_account = var.billing_account

  main_availability_zone = var.main_availability_zone
  location               = var.location

  project_name = var.project_name
  project_id   = var.project_id

  keyring     = var.keyring
  keyring_key = var.keyring_key

  big_robot_group = var.big_robot_group
  big_robot_name  = var.big_robot_name
  big_robot_email = var.big_robot_email

  # State bucket
  backend_bucket_name = var.backend_bucket_name
  bucket_path_prefix  = var.bucket_path_prefix
}

```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_network.network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_shared_vpc_host_project.host](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_shared_vpc_host_project) | resource |
| [google_compute_subnetwork.default_subnet](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_kms_crypto_key.key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key) | resource |
| [google_kms_key_ring_iam_policy.key_ring_policy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring_iam_policy) | resource |
| [google_service_account_key.mykey](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |
| [random_string.random-key-name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [google_client_config.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [google_cloud_identity_groups.cloud_identity_group_basic](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/cloud_identity_groups) | data source |
| [google_iam_policy.keyEditor](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/iam_policy) | data source |
| [google_kms_key_ring.keyring](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/kms_key_ring) | data source |
| [google_project.my_project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |
| [google_service_account.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/service_account) | data source |
| [google_storage_bucket.bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/storage_bucket) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_bucket_name"></a> [backend\_bucket\_name](#input\_backend\_bucket\_name) | name of the bucket that will hold the terraform state | `string` | `"slim"` | no |
| <a name="input_big_robot_email"></a> [big\_robot\_email](#input\_big\_robot\_email) | email of the top-level service account | `string` | n/a | yes |
| <a name="input_big_robot_group"></a> [big\_robot\_group](#input\_big\_robot\_group) | group for top-level service accounts | `string` | n/a | yes |
| <a name="input_big_robot_name"></a> [big\_robot\_name](#input\_big\_robot\_name) | Name of the top-level service account | `string` | n/a | yes |
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | the billing account you want all this to go under | `string` | n/a | yes |
| <a name="input_bucket_path_prefix"></a> [bucket\_path\_prefix](#input\_bucket\_path\_prefix) | path to the terrafom state in the bucket | `string` | n/a | yes |
| <a name="input_keyring"></a> [keyring](#input\_keyring) | Name for your keyring decryption key | `string` | n/a | yes |
| <a name="input_keyring_key"></a> [keyring\_key](#input\_keyring\_key) | name for the key you will create in the keyring | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | geographic location/region | `string` | n/a | yes |
| <a name="input_main_availability_zone"></a> [main\_availability\_zone](#input\_main\_availability\_zone) | availability zone within your region/location | `string` | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | your GCP organization name | `string` | n/a | yes |
| <a name="input_organization_id"></a> [organization\_id](#input\_organization\_id) | gcloud projects describe <project> --format='value(parent.id)' | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | machine readable project name | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The human-readbale project name string | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_google_kms_crypto_key_id"></a> [google\_kms\_crypto\_key\_id](#output\_google\_kms\_crypto\_key\_id) | n/a |
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | n/a |
| <a name="output_service_account_key_id"></a> [service\_account\_key\_id](#output\_service\_account\_key\_id) | n/a |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | n/a |
<!-- END_TF_DOCS -->
