provider "aws" {
    version = "~> 1.14"
    region  = "${var.region}"
}

resource "aws_route53_zone" "test_zone" {
    name              = "${var.domain}"
    comment           = "Route53 DNS zone for tiguard.technology"
    delegation_set_id = "${var.delegation_id}"
}

module "route53-o365" {
    source = "../.."

    domain          = "${var.domain}"
    zone_id         = "${aws_route53_zone.test_zone.zone_id}"
    ms_txt          = "ms12345678"
}
