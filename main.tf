# Creates a new project + basics in gcp

module "gcp-tf-base" {

  source = "git::https://github.com/cloudymax/modules-gcp-tf-base.git?ref=v0.0.1"
  
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

  # State bucket
  backend_bucket_name = ""
  bucket_path_prefix  = ""

}