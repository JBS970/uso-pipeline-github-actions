# Ao inves de usar a funcao file() com apontando para a chave,teremos variaveis que conterá o valor dessa chave
# Neste o valor default só será definido quando ,eu definir a pipeline
variable "aws_key_pub" {
  description = "Chave pública para a máquina AWS"
  type        = string
}

variable "azure_key_pub" {
  description = "Chave pública para a máquina Azure"
  type        = string
}