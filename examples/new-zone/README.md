# Usage with a new Route53 hosted zone

If you're creating a new Route53 hosted zone for the domain, the `aws_route53_zone` resource should pass the new zone ID to the module.

```hcl
resource "aws_route53_zone" "zone" {
    name = "example.com"
}

module "route53_o365" {
    source = "tiguard/route53-o365/aws"

    domain  = "example.com"
    zone_id = "${aws_route53_zone.zone.zone_id}"
    ms_txt  = "ms12345678"
}
```

This example creates all Office 365 DNS records for the domain.
