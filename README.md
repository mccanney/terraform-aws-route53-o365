# AWS Office 365 Route53 Terraform Module

[![CircleCI](https://circleci.com/gh/tiguard/terraform-aws-office365.svg?style=shield)](https://circleci.com/gh/tiguard/terraform-aws-office365)
[![GitHub release](https://img.shields.io/github/release/tiguard/terraform-aws-office365.svg?style=flat-square)](https://github.com/tiguard/terraform-aws-office365)
[![license](https://img.shields.io/github/license/tiguard/terraform-aws-office365.svg?style=flat-square)](https://github.com/tiguard/terraform-aws-office365/blob/master/LICENSE.md)

A terraform module which creates, in AWS Route53, the [DNS records](https://support.office.com/article/External-Domain-Name-System-records-for-Office-365-c0531a6f-9e25-4f2d-ad0e-a70bfef09ac0) required by Office 365.

## Usage

```hcl
module "route53_o365" {
    source = "tiguard/route53-o365/aws"

    domain          = "example.com"
    zone_id         = "${aws_route53_zone.zone_name.zone_id}"
    ms_txt          = "ms12345678"
    enable_exchange = true
    enable_sfb      = true
    enable_mdm      = true
}
```

## Examples

* [Usage with new zone](examples/new-zone/README.md)
* [Usage with existing zone](examples/existing-zone/README.md)

## Contributing

Please use the [issue tracker](https://github.com/tiguard/terraform-aws-route53-o365/issues) to file any bug reports or make feature requests.

## License

Released under the [MIT license](LICENSE.md).
