# modules-gcp-tf-base

A modularized version of https://github.com/cloudymax/gcp-tf-basee for those who prefer that workflow

## Local Source

```hcl

# Creates a new project + basics in gcp

module "gcp-tf-base" {

  source = "./gcp-tf-base"

  # Account options
  organization     = "example.com"
  organization_id  = "1234567890"
  credentials_path = "/Users/<user>/.config/gcloud/application_default_credentials.json"
  billing_account  = "some account"

  # Geographic Options
  main_availability_zone = "some-zone1-d"
  location               = "some-zone1"

  # Project 
  project_name = "GKE Example"
  project_id   = "gke-example"

  # Keyring
  keyring     = "example"
  keyring_key = "example-key"

  # IAM
  big_robot_group = "top-level-admins"
  big_robot_name  = "examplename"

  # State bucket
  backend_bucket_name = "backend-state-storage"
  bucket_path_prefix  = "terraform/state"

}

```


## Remote Source  

```hcl

# Creates a new project + basics in gcp
module "gcp-tf-base" {

  source  = "git::https://github.com/cloudymax/modules-gcp-tf-base.git?ref=v0.0.2"

}

```