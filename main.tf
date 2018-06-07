provider "template" {
    version = "~> 1.0"
}

data "template_file" "domain_guid" {
    template = "${replace(var.domain, ".", "-")}"
}

locals {
    o365_mx   = "${format("10 %s.mail.protection.outlook.com", data.template_file.domain_guid.rendered)}"
    o365_spf  = "v=spf1 include:spf.protection.outlook.com -all"
    dkim_dom  = "${format("%s._domainkey.%s.onmicrosoft.com", data.template_file.domain_guid.rendered, var.tenant_name)}"
    dkim = [
        {
            name  = "${format("selector1._domainkey.%s", var.domain)}"
            value = "${format("selector1-%s", local.dkim_dom)}"
        },
        {
            name  = "${format("selector2._domainkey.%s", var.domain)}"
            value = "${format("selector2-%s", local.dkim_dom)}"
        },
    ]
    sfb = [
        {
            name   = "lyncdiscover"
            record = "webdir.online.lync.com"
            type   = "CNAME"
        },
        {
            name   = "sip"
            record = "sipdir.online.lync.com"
            type   = "CNAME"
        },
        {
            name   = "_sipfederationtls._tcp"
            record = "100 1 5061 sipfed.online.lync.com"
            type   = "SRV"
        },
        {
            name   = "_sip._tls"
            record = "100 1 443 sipdir.online.lync.com"
            type   = "SRV"
        }
    ]
    mdm = [
        {
            name   = "enterpriseregistration"
            record = "enterpriseregistration.windows.net"
        },
        {
            name   = "enterpriseenrollment"
            record = "enterpriseenrollment.manage.microsoft.com"
        }
    ]
}

#################
# Exchange Online
#################

resource "aws_route53_record" "mx" {
    count   = "${var.enable_exchange && var.enable_custom_mx < 1 ? 1 : 0}"

    zone_id = "${var.zone_id}"
    name    = ""
    records = ["${local.o365_mx}"]
    type    = "MX"
    ttl     = "${var.ttl}"
}

resource "aws_route53_record" "custom_mx" {
    count   = "${var.enable_exchange && var.enable_custom_mx && length(var.custom_mx_record) > 0 ? 1 : 0}"

    zone_id = "${var.zone_id}"
    name    = ""
    records = ["${var.custom_mx_record}"]
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
    count   = "${var.enable_exchange && length(var.ms_txt) > 0 ? 1 : 0}"

    zone_id = "${var.zone_id}"
    name    = ""
    records = ["MS=${var.ms_txt}","${local.o365_spf}"]
    type    = "TXT"
    ttl     = "${var.ttl}"
}

resource "aws_route53_record" "dmarc" {
    count   = "${var.enable_exchange && var.enable_dmarc && length(var.dmarc_record) > 0 ? 1 : 0}"

    zone_id = "${var.zone_id}"
    name    = "_dmarc"
    records = ["${var.dmarc_record}"]
    type    = "TXT"
    ttl     = "${var.ttl}"
}

resource "aws_route53_record" "dkim" {
    count   = "${var.enable_exchange && var.enable_dkim && length(var.tenant_name) > 0 ? length(local.dkim) : 0}"

    zone_id = "${var.zone_id}"
    name    = "${lookup(local.dkim[count.index], "name")}"
    records = ["${lookup(local.dkim[count.index], "value")}"]
    type    = "CNAME"
    ttl     = "${var.ttl}"
}

####################
# Skype for Business
####################

resource "aws_route53_record" "sfb" {
    count   = "${var.enable_sfb ? length(local.sfb) : 0}"

    zone_id = "${var.zone_id}"
    name    = "${lookup(local.sfb[count.index], "name")}"
    records = ["${lookup(local.sfb[count.index], "record")}"]
    type    = "${lookup(local.sfb[count.index], "type")}"
    ttl     = "${var.ttl}"
}

##########################
# Mobile Device Management
##########################

resource "aws_route53_record" "mdm" {
    count   = "${var.enable_mdm ? length(local.mdm) : 0}"

    zone_id = "${var.zone_id}"
    name    = "${lookup(local.mdm[count.index], "name")}"
    records = ["${lookup(local.mdm[count.index], "record")}"]
    type    = "CNAME"
    ttl     = "${var.ttl}"
}
