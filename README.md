# Terraform Sandbox
## Getting Started
The below instructions assume that you are using AWS as your provider. 
### Terraform Installation
For mac users, install the CLI package using the brew package manager:
```sh
# Update brew
$ brew update
# Install terraform
$ brew install terraform
```
### Accessing Variables
Access keys and secrets should not be stored in source control. Create a new file called `secrest.auto.tfvars` and add variables for your AWS access keys:
```sh
# Create the secrest variable file
$ touch secrets.auto.tfvars
# Add your access key
$ echo access_key = \"<YOUR_ACCESS_KEY>\" >> secrets.auto.tfvars
# Add you secret key
$ echo access_key = \"<YOUR_SECRET_KEY>\" >> secrest.auto.tfvars
```
The additional `.auto.` tells terraform that this variable file should be loaded by default. This file already exists in the `.gitignore` so you won't have to worry about adding it. Variables that do not contain secrets should be stored in the `terraform.tfvars` or any other file that you create with a `.tfvars` (maunual load with `-var-file="<filename>"`) or a `.auto.tfvars` extension. 
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
