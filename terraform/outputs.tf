output "instance_ip_addr_mast" {
  value = aws_instance.master.public_ip
}

output "instance_ip_addr_rep" {
  value = aws_instance.replica.public_ip
}

output "instance_ip_addr_mast1" {
  value = aws_instance.master.private_ip
}

output "instance_ip_addr_rep1" {
  value = aws_instance.replica.private_ip
}
