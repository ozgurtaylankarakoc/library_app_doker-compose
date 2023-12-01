resource "aws_instance" "host" {
  ami             = data.aws_ami.ami.id
  instance_type   = var.ins-type
  key_name        = var.key
  user_data       = filebase64("${path.module}/userdata.sh")
  security_groups = [data.aws_security_group.sec-gr.name]
  tags = {
    Name = "Web server for books_db"
  }
  depends_on = [ github_repository_file.dataforapp ]
}

resource "github_repository" "repoforapp" {
  name       = "books-db"
  visibility = "private"
  auto_init = true
}

variable "files" {
  default = ["library-api.py", "docker-compose.yml", "Dockerfile", "requirements.txt"]
}
resource "github_repository_file" "dataforapp" {
  repository = github_repository.repoforapp.name
  for_each = toset(var.files)
  content = file(each.value)
  file = each.value
  overwrite_on_create = true
}

output "dns" {
  value = aws_instance.host.public_dns
}