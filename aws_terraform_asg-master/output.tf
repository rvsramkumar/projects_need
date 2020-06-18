output "ELB_DNS_Name" {
  value = "${aws_lb.gogoelb.dns_name}"
}
