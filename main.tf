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

  # State bucket
  backend_bucket_name = ""
  bucket_path_prefix  = ""

}