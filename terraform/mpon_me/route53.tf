resource "aws_route53_zone" "mpon_me" {
  name = "mpon.me."
}

resource "aws_route53_record" "www_mpon_me" {
  zone_id = aws_route53_zone.mpon_me.zone_id
  name    = "www.mpon.me"
  type    = "CNAME"
  ttl     = 60
  records = ["hatenablog.com"]
}