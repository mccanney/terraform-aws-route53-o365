provider "template" {
    version = "~> 1.0"
}

data "template_file" "mx_record" {
    template = "10 ${replace("${var.domain}", ".", "-")}.mail.protection.outlook.com"
}

#################
# Exchange Online
#################

resource "aws_route53_record" "mx" {
    count   = "${var.enable_exchange ? 1 : 0}"

    zone_id = "${var.zone_id}"
    name    = ""
    records = ["${data.template_file.mx_record.rendered}"]
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
    records = ["MS=${var.ms_txt}","v=spf1 include:spf.protection.outlook.com -all"]
    type    = "TXT"
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
