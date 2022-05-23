# modules-gcp-tf-base

A modularized version of https://github.com/cloudymax/gcp-tf-basee for those who prefer that workflow

## Local Source

```hcl

# Creates a new project + basics in gcp
module "gcp-tf-base" {

  source  = "./gcp-tf-base"
  
  organization     = ""
  organization_id  = ""
  credentials_path = ""
  billing_account  = ""

  main_availability_zone = ""
  location               = ""

  project_name = ""
  project_id   = ""

  keyring     = ""
  keyring_key = ""

  big_robot_group = ""
  big_robot_name  = ""

  backend_bucket_name = ""
  bucket_path_prefix  = ""

}

```


## Remote Source  

```hcl

# Creates a new project + basics in gcp
module "gcp-tf-base" {

  source  = "git::https://github.com/cloudymax/modules-gcp-tf-base.git?ref=v0.0.1"
  
  organization     = ""
  organization_id  = ""
  credentials_path = ""
  billing_account  = ""

  main_availability_zone = ""
  location               = ""

  project_name = ""
  project_id   = ""

  keyring     = ""
  keyring_key = ""

  big_robot_group = ""
  big_robot_name  = ""

  backend_bucket_name = ""
  bucket_path_prefix  = ""

}

```