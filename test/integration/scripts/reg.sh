#!/bin/bash

export PATH=$PATH:~/.local/bin
export DOMAIN="tiguard.technology"
export ZONE_ID=$(aws route53 list-hosted-zones-by-name --dns-name $DOMAIN --query "HostedZones[0].Id" --output text)
export SOA=$(aws route53 list-resource-record-sets --hosted-zone-id $ZONE_ID --query "ResourceRecordSets[?Type=='SOA'].ResourceRecords[0].Value" --output text)
export REGEX="^ns1\.titanium.*hostmaster\.titanium.*"

if [[ $SOA =~ $REGEX ]]; then
	echo "SOA is already set"
	exit 0
else
	aws route53domains --region us-east-1 update-domain-nameservers --cli-input-json file://test/integration/registrar.json
fi
