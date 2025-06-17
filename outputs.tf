# Os outputs são para gerar os ips das maquinas virtuais,para poder acessar e testar
output "vm_aws_ip" {
  description = "IP da Maquina virtual criada na AWS"
  value       = aws_instance.vm.public_ip
}

output "vm_azure_ip" {
  description = "IP da Maquina virtual criada na azure"
  value       = azurerm_linux_virtual_machine.vm.public_ip_address
}