# Using the module with a new Route53 zone

If you're creating a new Route53 hosted zone for the domain, the `aws_route53_zone` resource can pass the new zone ID to the module.

```hcl
resource "aws_route53_zone" "zone" {
    name = "example.com"
}

module "route53_o365" {
    source = "tiguard/route53-o365/aws"

    domain          = "example.com"
    zone_id         = "${aws_route53_zone.zone.zone_id}"
    ms_txt          = "ms12345678"
    enable_exchange = true
    enable_sfb      = true
    enable_mdm      = true
}
```
