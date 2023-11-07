provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAWOPKGGK7UQC4VSXG"
  secret_key = "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"
}

#security group
resource "aws_security_group" "web_access" {
  name        = "web_access"
  description = "allow ssh and http"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}

resource "aws_key_pair" "terraform_ec2_key" {
	key_name = "terraform-key"
	public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCXa21xi1TRoRiuQqb+1Q+w0cOwoSh6nD6lY+dQK3ayUaH5M4m+waAeIVs36kK8bkSI1grjbwwSMP2ZmVwU3i6ryrZ5b/PLS/S+oveWx1qFfxApt8p0NYpeXyCBPn3sYyzAetyzxCDdQfF9Ln018Wsq/WUBrYVR1rfP13Q1x7dF0pKAWj06Q50dSjiV2EmPPalC1Sm3mB7/BHSTtZvdfzjElWeQM1RoELiNjihV/Rqf3tl1oOwpUNZ83CplFpLgeq4q09ubDF0tKbflMtiKMnjbrzvr1T2GP4IXHNnjPOKtATwH+9/Q834amzBGOiOKk0zbSo5Zes6cHQIoyY4DGS6rIcaBUxZCiiVF6fiXT+uBGxIReQV0xblrgkTxhA7DI8IRT+Cy/J03vgecL82+Do+7P1lU7FO6aZptzjici7mA78OwJtEfA0mjftlZP9svl7E22JHX6OxbL4JoS7Fjx7HDO4io5GUJrimHx11FxaU6Juh1iZpT+/voicCE/c1ZqVM= root@terraform"

}
#security group end here


resource "aws_instance" "web-server" {
  ami               = "ami-02e94b011299ef128"
  availability_zone = "ap-south-1a"
  instance_type     = "t2.micro"
  security_groups   = ["${aws_security_group.web_access.name}"]
  key_name = aws_key_pair.terraform_ec2_key.key_name
  tags = {
    Name     = "hello-Mumbai"
    Stage    = "testing"
    Location = "INDIA"
  }

}

