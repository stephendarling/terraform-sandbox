# Variables must be declared in the file for which they will be used
variable "access_key" {}
variable "secret_key" {}
variable "region" {}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "example-instance" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"
  tags {
    Name = "terraform-example-instance"
  }

  # This provisioner is set to run only at the time the resource is created
  provisioner "local-exec" {
    # The result of the command is stored on the host machine in the specified location below
    command = "echo ${aws_instance.example-instance.public_ip} is the IP address for ${aws_instance.example-instance.tags.Name}> local-exec-output/creation-provisioner.txt"
  }

  provisioner "local-exec" {
    # The when = "destroy" tells this to only run when the instance was destroyed
    when = "destroy"
    command = "echo ${aws_instance.example-instance.tags.Name} was destroyed > local-exec-output/deletion-provisioner.txt"
  }

}

resource "aws_eip" "ip" {
  instance = "${aws_instance.example-instance.id}"
}