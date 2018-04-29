# DKIM & DMARC usage

## DomainKeys Identified Mail (DKIM)

To enable DKIM signing of outgoing e-mail from a custom Office 365 domain:

```hcl
data "aws_route53_zone" "zone" {
    name = "example.com."
}

module "route53_o365" {
    source = "tiguard/route53-o365/aws"

    domain          = "example.com"
    zone_id         = "${data.aws_route53_zone.zone.zone_id}"
    ms_txt          = "ms12345678"
    enable_exchange = true
    enable_dkim     = true
    tenant_name     = "contoso"
}
```

`enable_dkim` enables or disables the creation of the DKIM DNS CNAME records according to Microsoft's [Office 365 DKIM guide](https://technet.microsoft.com/en-gb/library/mt695945.aspx).  The Office 365 `tenant_name` (*i.e.* the `contoso` part of `contoso.onmicrosoft.com`) must also be set.

## Domain-based Message Authentication Reporting and Conformance (DMARC)

To enable a DMARC record for a custom Office 365 domain:

```hcl
data "aws_route53_zone" "zone" {
    name = "example.com."
}

module "route53_o365" {
    source = "tiguard/route53-o365/aws"

    domain          = "example.com"
    zone_id         = "${data.aws_route53_zone.zone.zone_id}"
    ms_txt          = "ms12345678"
    enable_exchange = true
    enable_dmarc    = true
    dmarc_record    = "v=DMARC1; p=none; rua=mailto:dmarc@tiguard.technology; ruf=mailto:dmarc@tiguard.technology"
}
```

`enable_dmarc` enables or disables the creation of the DMARC DNS TXT record according to Microsoft's [Office 365 DMARC guide](https://technet.microsoft.com/en-gb/library/mt734386.aspx).  The required `dmarc_record` must also be provided and be syntactically valid since the module does no checking.  See [dmarcian.com](https://dmarcian.com/dmarc-inspector/) for help.
