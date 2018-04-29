# AWS Office 365 Route53 Terraform Module

[![CircleCI](https://circleci.com/gh/tiguard/terraform-aws-route53-o365.svg?style=shield)](https://circleci.com/gh/tiguard/terraform-aws-route53-o365)
[![GitHub release](https://img.shields.io/github/release/tiguard/terraform-aws-route53-o365.svg?style=flat-square)](https://github.com/tiguard/terraform-aws-route53-o365/releases)
[![license](https://img.shields.io/github/license/tiguard/terraform-aws-route53-o365.svg?style=flat-square)](https://github.com/tiguard/terraform-aws-route53-o365/blob/master/LICENSE.md)

A terraform module which creates, in AWS Route53, the [DNS records](https://support.office.com/article/External-Domain-Name-System-records-for-Office-365-c0531a6f-9e25-4f2d-ad0e-a70bfef09ac0) required by Office 365.

## Usage

```hcl
module "route53_o365" {
    source = "tiguard/route53-o365/aws"

    domain          = "example.com"
    zone_id         = "${data.aws_route53_zone.zone_name.zone_id}"
    ms_txt          = "ms12345678"
    enable_exchange = false
    enable_sfb      = false
    enable_mdm      = false
    enable_dkim     = false
    enable_dmarc    = false
}
```

* `enable_exchange` controls whether the required DNS records for Exchange Online should be created or not.
* `enable_sfb` controls whether the required DNS records for Skype for Business should be created or not.
* `enable_mdm` controls whether the DNS for Mobile Device Management should be created or not.
* `enable_dkim` controls whether the required DNS records for DKIM signing for the custom domain should be created or not.
* `enable_dmarc` controls whether a DMARC DNS record for the custom domain should be created or not.

By default, all DNS records for Exchange Online, Skype for Business and MDM are set to `true`, DKIM and DMARC are set to `false`.

## Examples

* [Usage with new zone](examples/new-zone/README.md)
* [Usage with existing zone](examples/existing-zone/README.md)
* [DKIM & DMARC usage](examples/dkim-dmarc/README.md)

## Contributing

Please use the [issue tracker](https://github.com/tiguard/terraform-aws-route53-o365/issues) to file any bug reports or make feature requests.

## License

Released under the [MIT license](LICENSE.md).
