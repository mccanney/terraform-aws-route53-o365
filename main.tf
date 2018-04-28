provider "template" {
    version = "~> 1.0"
}

data "template_file" "domain_guid" {
    template = "${replace("${var.domain}", ".", "-")}"
}

locals {
    o365_mx   = "10 ${data.template_file.domain_guid.rendered}.mail.protection.outlook.com"
    o365_spf  = "v=spf1 include:spf.protection.outlook.com -all"
    dkim_dom  = "${data.template_file.domain_guid.rendered}._domainkey.${var.tenant_name}.onmicrosoft.com"
    dkim = [
        {
            name  = "selector1._domainkey.${var.domain}"
            value = "selector1-${local.dkim_dom}"
        },
        {
            name  = "selector2._domainkey.${var.domain}"
            value = "selector2-${local.dkim_dom}"
        },
    ]
}

#################
# Exchange Online
#################

resource "aws_route53_record" "mx" {
    count   = "${var.enable_exchange ? 1 : 0}"

    zone_id = "${var.zone_id}"
    name    = ""
    records = ["${local.o365_mx}"]
    type    = "MX"
    ttl     = "${var.ttl}"
}

resource "aws_route53_record" "autodiscover" {
    count   = "${var.enable_exchange ? 1 : 0}"

    zone_id = "${var.zone_id}"
    name    = "autodiscover"
    records = ["autodiscover.outlook.com"]
    type    = "CNAME"
    ttl     = "${var.ttl}"
}

resource "aws_route53_record" "spf" {
    count   = "${var.enable_exchange ? 1 : 0}"

    zone_id = "${var.zone_id}"
    name    = ""
    records = ["MS=${var.ms_txt}","${local.o365_spf}"]
    type    = "TXT"
    ttl     = "${var.ttl}"
}

resource "aws_route53_record" "dmarc" {
    count   = "${var.enable_exchange && var.enable_dmarc ? 1 : 0}"

    zone_id = "${var.zone_id}"
    name    = "_dmarc"
    records = ["${var.dmarc_record}"]
    type    = "TXT"
    ttl     = "${var.ttl}"
}

resource "aws_route53_record" "dkim" {
    count   = "${var.enable_dkim ? length(local.dkim) : 0}"

    zone_id = "${var.zone_id}"
    name    = "${lookup(local.dkim[count.index], "name")}"
    records = ["${lookup(local.dkim[count.index], "value")}"]
    type    = "CNAME"
    ttl     = "${var.ttl}"
}

####################
# Skype for Business
####################

resource "aws_route53_record" "lyncdiscover" {
    count   = "${var.enable_sfb ? 1 : 0}"

    zone_id = "${var.zone_id}"
    name    = "lyncdiscover"
    records = ["webdir.online.lync.com"]
    type    = "CNAME"
    ttl     = "${var.ttl}"
}

resource "aws_route53_record" "sip" {
    count   = "${var.enable_sfb ? 1 : 0}"

    zone_id = "${var.zone_id}"
    name    = "sip"
    records = ["sipdir.online.lync.com"]
    type    = "CNAME"
    ttl     = "${var.ttl}"
}

resource "aws_route53_record" "sipfed" {
    count   = "${var.enable_sfb ? 1 : 0}"

    zone_id = "${var.zone_id}"
    name    = "_sipfederationtls._tcp"
    records = ["100 1 5061 sipfed.online.lync.com"]
    type    = "SRV"
    ttl     = "${var.ttl}"
}

resource "aws_route53_record" "sipdir" {
    count   = "${var.enable_sfb ? 1 : 0}"

    zone_id = "${var.zone_id}"
    name    = "_sip._tls"
    records = ["100 1 443 sipdir.online.lync.com"]
    type    = "SRV"
    ttl     = "${var.ttl}"
}

##########################
# Mobile Device Management
##########################

resource "aws_route53_record" "enterpriseregistration" {
    count   = "${var.enable_mdm ? 1 : 0}"

    zone_id = "${var.zone_id}"
    name    = "enterpriseregistration"
    records = ["enterpriseregistration.windows.net"]
    type    = "CNAME"
    ttl     = "${var.ttl}"
}

resource "aws_route53_record" "enterpriseenrollment" {
    count   = "${var.enable_mdm ? 1 : 0}"

    zone_id = "${var.zone_id}"
    name    = "enterpriseenrollment"
    records = ["enterpriseenrollment.manage.microsoft.com"]
    type    = "CNAME"
    ttl     = "${var.ttl}"
}
