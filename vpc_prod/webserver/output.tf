output "bastion_publicIP" {
  value = aws_instance.bastionhost.public_ip
}

output "bastion_privateIP" {
  value = aws_instance.bastionhost.private_ip
}

output "privateVM5_ip" {
  value = aws_instance.VM5.private_ip
}

output "privateVM6_ip" {
  value = aws_instance.VM6.private_ip
}

output "publicVM1_ip" {
  value = aws_instance.publicVM1.public_ip
}

output "publicVM3_ip" {
  value = aws_instance.publicVM3.public_ip
}

outputs "publicVM4_ip" {
  value = aws_instance.publicVM4.public_ip
}

