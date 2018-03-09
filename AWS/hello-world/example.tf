variable access_key {}
variable secret_key {}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
	bucket = "terraform_getting_started"
	acl = "private"
}

resource "aws_instance" "example" {
	ami = "ami-b374d5a5"
	instance_type = "t2.micro"
	depends_on = ["aws_s3_bucket.example"]
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}"
}
