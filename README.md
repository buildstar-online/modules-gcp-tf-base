# Getting started with GCP

In this tutorial we will create:

- A GCP Project
- Security Group
- State Bucket
- Service Account
- IAM permissions
- KMS Key

These items are required to be in-place prior to beginning to work with terraform.


## Setting-up via the gCloud CLI

[Installing the gCloud CLI](https://cloud.google.com/sdk/docs/install)

or use docker the docker container `gcr.io/google.com/cloudsdktool/google-cloud-cli`


1. Log in
  
   ```bash
   gcloud auth login
   ``` 

2. Find your billing account ID:

   ```bash
   gcloud alpha billing accounts list
   
   or
   
   gcloud alpha billing accounts list --filter='NAME:<your user name>' --format='value(ACCOUNT_ID)'
   ```

3. Find your Organization ID
  
   ```bash
   gcloud organizations list
   
   or
   
   gcloud organizations list --filter='DISPLAY_NAME:<some org name>' --format='value(ID)'
   ```

4. Populate required variables with unique values for your own project.

   ```bash
   export PROJECT_NAME="An Easy To Read Name"
   export PROJECT_ID="machine-readable-project-name"
   export BIG_ROBOT_NAME="myserviceaccount"
   export BIG_ROBOT_EMAIL=$(echo $BIG_ROBOT_NAME@$PROJECT_ID.iam.gserviceaccount.com)
   export ORGANIZATION=
   export ORGANIZATION_ID=$(gcloud organizations list |grep $ORGANIZATION |awk '{print $2}')
   export LOCATION="europe-west4"
   export MAIN_AVAILABILITY_ZONE="europe-west4-a"
   export KEYRING="mykeyring"
   export KEYRING_KEY="terraform-key.json"
   export BILLING_ACCOUNT=""
   export GCLOUD_CLI_IMAGE_URL="gcr.io/google.com/cloudsdktool/google-cloud-cli"
   export GCLOUD_CLI_IMAGE_TAG="slim"
   export BACKEND_BUCKET_NAME="$PROJECT_ID-backend-state-storage"
   export BUCKET_PATH_PREFIX="terraform/state"
   ```

5. Enable required Apis (may take a couple minutes)

   ```bash
   gcloud services enable compute.googleapis.com
   gcloud services enable cloudresourcemanager.googleapis.com 
   gcloud services enable cloudidentity.googleapis.com 
   gcloud services enable cloudkms.googleapis.com
   gcloud services enable iamcredentials.googleapis.com
   gcloud services enable iam.googleapis.com
   ```
   
6. Create a new Project and set it as active, then enable billing

    ```bash
    gcloud projects create $PROJECT_ID --name="$PROJECT_NAME"
    gcloud config set project $PROJECT_ID
    gcloud alpha billing projects link $PROJECT_ID --billing-account $BILLING_ACCOUNT
    
    ```

7. Create a group:

    ```bash
    gcloud identity groups create "admin-bot-group@$ORGANIZATION" --organization=$ORGANIZATION_ID --display-name="top-level-bot-group"
    ```
   

8. Give the group some permissions:

    ```bash
    gcloud projects add-iam-policy-binding $PROJECT_ID \
      --member=group:"admin-bot-group@$ORGANIZATION" \
      --role=roles/iam.serviceAccountUser \
      --role=roles/compute.instanceAdmin.v1 \
      --role=roles/compute.osLogin

    gcloud projects add-iam-policy-binding $PROJECT_ID \
      --member=group:"admin-bot-group@$ORGANIZATION" \
      --role=roles/owner
      
    gcloud organizations add-iam-policy-binding "$ORGANIZATION_ID" \
      --member="group:admin-bot-group@$ORGANIZATION" \
      --role='roles/compute.xpnAdmin'
    ```
    
9. Create a Service Account and add the computer.serviceAgent role

   ```bash
   gcloud iam service-accounts create $BIG_ROBOT_NAME \
      --display-name="Authorative Service Account"
   
   gcloud projects add-iam-policy-binding $PROJECT_ID \
      --member=serviceAccount:"$BIG_ROBOT_EMAIL" \
      --role=roles/compute.serviceAgent \
   ```

10. Add the service account to the admin group:

    ```bash
    gcloud identity groups memberships add \
      --group-email="admin-bot-group@$ORGANIZATION" \
      --member-email=$BIG_ROBOT_EMAIL
    ```

11. Create a KeyRing and a key

    ```bash
    gcloud kms keyrings create $KEYRING --location=$LOCATION

    gcloud kms keys create $KEYRING_KEY \
        --keyring $KEYRING \
        --location $LOCATION \
        --purpose "encryption"
    ```

12. Then we create a service-account key, auth the key and assume the identity

    ```bash
    gcloud iam service-accounts keys create $KEYRING_KEY \
        --iam-account=$BIG_ROBOT_EMAIL

    gcloud auth activate-service-account "$BIG_ROBOT_EMAIL" \
        --key-file=$(pwd)/$KEYRING_KEY  \
        --project=$PROJECT_ID
    ```

13. Create backend bucket for the state and enable versioning:

    ```bash
    gsutil mb gs://$BACKEND_BUCKET_NAME

    gsutil versioning set on gs://$BACKEND_BUCKET_NAME
    ```

14. Clone the module repo [HERE](https://github.com/cloudymax/modules-gcp-tf-base) and populate the templates. envsubst requires the apt packages `gettext`.

    ```bash
    git clone https://github.com/cloudymax/modules-gcp-tf-base
    cd modules-gcp-tf-base
    envsubst < "backend.tf.template" > "backend.tf"
    envsubst < "terraform.tfvars.template" > "terraform.tfvars"
    envsubst < "providers.tf.template" > "providers.tf"
    ```

15. Init and apply terraform

    ```bash
    docker run -it -v $(pwd):/terraform \
    -w /terraform \
    hashicorp/terraform:latest init
   
    docker run -it -v $(pwd):/terraform \
    -w /terraform \
    hashicorp/terraform:latest apply
    ```


## Remote Source  

```hcl

# Creates a new project + basics in gcp
module "gcp-tf-base" {

  source  = "git::https://github.com/cloudymax/modules-gcp-tf-base.git?ref=v0.0.3"

}

```

## Managing with Terraform through a service account

After you have the base resources in place and your have a service-account identity + credentials, you can run terraform locally or in a CI system like GitHub Actions or Jenkins.


## Whats NOT in this project (yet)

This does NOT include a bastion jump box, firewall rules, or workload identities. These will be done later in a GKE or Compute VM specific repo. This is just for the basics you need to have terraform manage the life-cycle of GCP projects.

This guide is meant to be a low-effort general solution/example.

If you need a more in-depth guides on GKE, I would recommend reading:

- [GKE private cluster with a bastion host](https://medium.com/google-cloud/gke-private-cluster-with-a-bastion-host-5480b44793a7) by Peter Hrvola
- [How to use a Private Cluster in Kubernetes Engine](https://github.com/GoogleCloudPlatform/gke-private-cluster-demo) by the GCP team
- [Google Cloud Workload Identity with Kubernetes and Terraform](https://www.cobalt.io/blog/google-cloud-workload-identity-with-kubernetes-and-terraform) by Nikola Velkovski





```bash
docker run -it -v $(pwd):/terraform \
-w /terraform \
hashicorp/terraform:latest init
```

