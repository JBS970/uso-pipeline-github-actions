# Como a azure não permite tags,usamos variaveis locais
locals {
  common_tags = {
    owner      = "joaosilva"
    managed-by = "terraform"
  }
}