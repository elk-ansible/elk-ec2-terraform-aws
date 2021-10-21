####################
# Private DNS Zone #
####################
resource "aws_route53_zone" "example" {
  name = "sciviz.co"
  vpc {
    vpc_id = aws_vpc.tf_main.id
  }
}

# Elasticsearch Nodes Private DNS
resource "aws_route53_record" "www" {
  zone_id  = aws_route53_zone.example.zone_id
  for_each = toset(["es01", "es02", "es03"])
  name     = each.key
  type     = "A"
  ttl      = "300"
  records  = [module.ec2_instance[each.key].private_ip]
}
# Kibana  Private  DNS
resource "aws_route53_record" "kibana_prv" {
  zone_id  = aws_route53_zone.example.zone_id
  name     = "kibana"
  type     = "CNAME"
  ttl      = "300"
  records  = [aws_instance.kibana_server.private_dns]
}
# Enterprise Search Private  DNS
resource "aws_route53_record" "ent_search_prv" {
  zone_id  = aws_route53_zone.example.zone_id
  name     = "ent-search"
  type     = "CNAME"
  ttl      = "300"
  records  = [aws_instance.kibana_server.private_dns]
}
# APM Server Private DNS
resource "aws_route53_record" "apm_serv_prv" {
  zone_id  = aws_route53_zone.example.zone_id
  name     = "apm-server"
  type     = "CNAME"
  ttl      = "300"
  records  = [aws_instance.kibana_server.private_dns]
}
# Logstash Private  DNS
resource "aws_route53_record" "logstash_prv" {
  zone_id  = aws_route53_zone.example.zone_id
  name     = "logstash"
  type     = "CNAME"
  ttl      = "300"
  records  = [aws_instance.kibana_server.private_dns]
}
###################
# Public DNS Zone #
###################
resource "aws_route53_zone" "example_public" {
  name = "sciviz.co"
}

# Elasticsearch Nodes Public DNS
resource "aws_route53_record" "www_public" {
  zone_id  = aws_route53_zone.example_public.zone_id
  for_each = toset(["es01", "es02", "es03"])
  name     = each.key
  type     = "A"
  ttl      = "300"
  records  = [module.ec2_instance[each.key].public_ip]
}
# Kibana Public DNS
resource "aws_route53_record" "kibana_pub" {
  zone_id  = aws_route53_zone.example_public.zone_id
  name     = "kibana"
  type     = "CNAME"
  ttl      = "300"
  records  = [aws_instance.kibana_server.public_dns]
}
# Enterprise Search Public DNS
resource "aws_route53_record" "ent_search_pub" {
  zone_id  = aws_route53_zone.example_public.zone_id
  name     = "ent-search"
  type     = "CNAME"
  ttl      = "300"
  records  = [aws_instance.kibana_server.public_dns]
}
# APM Server Public DNS
resource "aws_route53_record" "apm_serv_pub" {
  zone_id  = aws_route53_zone.example_public.zone_id
  name     = "apm-server"
  type     = "CNAME"
  ttl      = "300"
  records  = [aws_instance.kibana_server.public_dns]
}
# Logstash Public DNS
resource "aws_route53_record" "logstash_pub" {
  zone_id  = aws_route53_zone.example_public.zone_id
  name     = "logstash"
  type     = "CNAME"
  ttl      = "300"
  records  = [aws_instance.kibana_server.public_dns]
}

