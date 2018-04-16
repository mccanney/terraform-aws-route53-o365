#!/bin/bash

export PATH=$PATH:~/.local/bin
export ZONE_ID=$(aws route53 list-hosted-zones-by-name --dns-name tiguard.technology --query "HostedZones[0].Id" --output text)

aws route53 change-resource-record-sets --hosted-zone-id $ZONE_ID --change-batch file://nameservers.json
