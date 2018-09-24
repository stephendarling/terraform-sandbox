# Terraform Sandbox
## Getting Started
The below instructions assume that you are using GCP as your provider. 
### Terraform Installation
For mac users, install the CLI package using the brew package manager:
```sh
# Update brew
$ brew update
# Install terraform
$ brew install terraform
```
### GCP Credentials
Your gcp credentials should not be stored in source control. Login to the GCP console and, from IAM, download the credentials for the account you want terraform to use when accessing GCP. Rename this to `account.json` and place it at the root of your project. It has already been added to .gitignore so you won't have to worry about it finding it's way back into source control. This credentials file is referenced in the `example.tf` file here:
```sh
...
provider "google" {
  credentials = "${file("account.json")}"
  project     = "mwp-sandbox-aaa-ers"
  region      = "us-central1"
}
```
### Using Variables
Variables that do not contain secrets should be stored in the `terraform.tfvars` or any other file that you create with a `.tfvars` (maunual load with `-var-file="<filename>"`) or a `.auto.tfvars` extension. 
To use variables in your `.tf` files, make sure to declare them at the top:
```sh
variable "<variable_name>" {}
```
## Running Commands
### Initialize
Run this to initialize the terraform project:
```sh
$ terraform init
```
### Apply
### Destroy
## Notes
This was originally intended to use with Cloud Functions on Python 3.7. As of now, cloud functions with terraform only support Node.js 6. There is a pull request in place to add a `runtime` parameter to the cloud_functions resource where you can configure Node, Python or Java. This will be put on hold until that becomes general availability. 
