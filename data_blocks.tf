data "aws_security_group" "sec-gr" {
  name = "ssh_http"
}
data "aws_ami" "ami" {
  owners = ["amazon"]
  filter {
    name   = "creation-date"
    values = ["2023-11-10T20:17:21.000Z"]
  }
}