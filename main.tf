variable "awsprops" {
    type = map
    default = {
    region = "ap-southeast-2"
    vpc = "vpc-06da4dddeefad6821"
    ami = "ami-0f5d1713c9af4fe30"
    itype = "t2.micro"
    subnet = "subnet-09f20f2d2d18a5d5e"
    publicip = true
    keyname = "Verity77ppkSydney"
    secgroupname = "VerityAppSecGrp"
  }
}
variable "GITHUB_TOKEN" { type= string } 

provider "aws" {
  region = lookup(var.awsprops, "region")
}

resource "aws_security_group" "verityappsg" {
  name = lookup(var.awsprops, "secgroupname")
  description = lookup(var.awsprops, "secgroupname")
  vpc_id = lookup(var.awsprops, "vpc")

  // To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  // To Allow Port 80 Transport
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  // To Allow Port 8080 Transport
  ingress {
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "verityapp" {
  ami = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  subnet_id = lookup(var.awsprops, "subnet") #FFXsubnet2
  associate_public_ip_address = lookup(var.awsprops, "publicip")
  key_name = lookup(var.awsprops, "keyname")
  user_data_base64 = base64encode(templatefile("./init-scrpt.sh", {
    GITHUB_TOKEN = "${var.GITHUB_TOKEN}"
  }))


  vpc_security_group_ids = [
    aws_security_group.verityappsg.id
  ]

  tags = {
    Name ="Verity App Server"
  }

  depends_on = [ aws_security_group.verityappsg ]
}


output "adminerurl" {
  value = format("%s%s%s", "http://", aws_instance.verityapp.public_ip, ":8080")
}

output "websiterul" {
  value = format("%s%s", "http://", aws_instance.verityapp.public_ip)
}

output "token" {
  value = "${var.GITHUB_TOKEN}"
}
