
# Create new security group to all port 443, 80, 22

resource "aws_key_pair" "generated_key" {
  key_name   = "wordpress_EC2_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9rQs/8wtOgDIC8yURrjoXtr9X+M5Yj6JBMheWtCXHP6G4co9Od9nbyq9eH2TxSoiNKJOAp+btbdV6641ZVjo+sm8ZLMjX9Jxu7e/Dz0FUNAi6wXfnPwFdklmBPupSnakuw0NZdxNMj8J18wZ7IGRpw+LDEiZiiBUjLxx2j8laU2m8COr4WTSgtqwTclGIHcqxId8g+08J2AgXwHTVjgBI7349WOLpMsNuaeiMIF3rmhkm274kR/k9BUU1CsP6rShV23wJuKt+Z0P98YtnT/zgp6lBXjkonz9/Pxc8hkmfYCm5/6w/lcEQ0dPFMBSKk0yQA4f0jNUKOua10CPLq5jSbmOk9StmV8p+WhLYt08pSgoLrUeaWL8iPQapu16Tl2CmhSV5zL5mYqzBqsQjvjP7QkZmL/b6EwsU8H36KyM7u0tnd/NGwDU8Hw4/HbWx29c0NjDAi+8rIQ1KvRnp1WzJpO407RpQ5uPtx0nFHqV2ODfqfpRkAMmGVG0YJSoK9qM= maydarous@pop-os"
}

resource "aws_security_group" "wordpress_sg" {
     name        = "wordpress_sg"
     description = "Allow incoming HTTP and HTTPS and SSH Connections"
     ingress {
         from_port = 80
         to_port = 80
         protocol = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
    }
     ingress {
         from_port = 443
         to_port = 443
         protocol = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
    }
     ingress {
         from_port = 22
         to_port = 22
         protocol = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
    }
}

# Create EC2 instance
resource "aws_instance" "wordpress_server" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  key_name      = "wordpress_EC2_key"
  security_groups = [aws_security_group.wordpress_sg.name]
  tags = {
    Name = "wordpress_server"
  }
}
