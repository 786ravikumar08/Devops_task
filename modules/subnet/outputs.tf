output "subnet_ids" {
  value = join(",",aws_subnet.sn.*.id)
}
