# Um bloco para criar a chave,outro para criar a mv
resource "aws_key_pair" "key" {
  key_name   = "aws-key-pipelines"
  public_key = var.aws_key_pub
}

resource "aws_instance" "vm" {
  ami           = "ami-0a87a69d69fa289be"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key.key_name # Acessa o bloco acima e usa o valor de key_name
  # Para obter o 'subnet_id' estamos usando um data source(ele busca os dados na aws) usando a referencia do data.nome-dado-a-ele. ai acessa outputs e subnet_id
  subnet_id = data.terraform_remote_state.vpc.outputs.subnet_id
  # idem acima, acessa vpc_security_group_ids usando a referencia do (no main.tf) data.nome-dado-a-ele. ai acessa outputs e security_group_id
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.security_group_id]
  associate_public_ip_address = true

  tags = {
    Name = "vm-terraform"
  }
}
