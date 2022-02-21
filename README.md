# The purpose of this repo is to show how to use functions in Terraform configuration language.

This repo is based on [HashiCorp learning guide](https://learn.hashicorp.com/tutorials/terraform/functions?in=terraform/configuration-language).

The configuration is creating an EC2 instance running a pre-built webapp.
Functions used:
 - [`templatefile`](https://www.terraform.io/language/functions/templatefile) - This function was used to create a `user_data` script to dynamically configure an EC2 instance with resource information.
 - [`lookup`](https://www.terraform.io/language/functions/lookup) - Function to pass a map output to a variable as an input,
 - [`concat`](https://www.terraform.io/language/functions/concat) - Function to concatenate and output multiple lists of rules to an AWS Security Group.
 
###### Template file

The template file is a shell script to configure and deploy an app using `${name}` and `${department}` information that Terraform will interpolate into the file from variables.

###### Function `templatefile`

In the `variables.tf` file  are defined the values of variables `user_name` `user_department`
In Terraform configuration file `main.tf` The `templatefile` function takes two arguments: the template file name and the template assignments in curly brackets (`{}`).

```
user_data = templatefile("user_data.tftpl", { department = var.user_department, name = var.user_name })}
```

###### Function `lookup`

The `lookup` function retrieves the value of a single element from a map, given its key. It will dynamically apply the region-appropriate AMI ID for the EC2 instance. There are three regions in the variable `aws_amis` to choosed from.

```
terraform apply -var "aws_region=eu-west-2"
terraform apply -var "aws_region=eu-central-1"
terraform apply -var "aws_region=eu-west-1"
```

###### Function `concat`

The concat function takes two or more lists and combines them into a single list.

Configuration currently contains two `aws_security_groups`: `sg_8080` - exposes port 8080 to everyone and `sg_22` - allows you to SSH into the EC2.


### Prerequisites to run the configuration

Some AWS knowledge (ec2 instance, security groups)

- The [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- AWS Credentials [configured for use with Terraform](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication)
- The [git CLI](https://git-scm.com/downloads)

**Note**:Some of the infrastructure in this configuration may not qualify for the AWS free tier. Destroy the infrastructure at the end of the guide to avoid unnecessary charges.

- The configuration is parameterized with variables declarations in file called `variables.tf`.
- You can change the values of the variables by your needs.

### Create and destroy the infrastructure

Clone the repository:
```
git clone https://github.com/krasteki/terraform-functions.git
```

Navigate to the repo directory:
```
cd terraform-functions
```

To be able to log in to the EC2 instance a `ssh key` is needed. To generate one use following command:
```
ssh-keygen -C "your_email@example.com" -f ssh_key
```

Initialize the configuration:
```
terraform init
```

Apply the configuration:
```
terraform apply
```

Log in to the EC2:
```
ssh ubuntu@$(terraform output -raw web_public_ip) -i ssh_key
```

Clean up resources to avoid additional charges:
```
terraform destroy
```
