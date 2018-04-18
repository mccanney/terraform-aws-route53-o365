#!/bin/bash

export PATH=$PATH:~/.local/bin
export DOMAIN="tiguard.technology"
export ZONE_ID=$(aws route53 list-hosted-zones-by-name --dns-name $DOMAIN --query "HostedZones[0].Id" --output text)
export REG_NS=$(aws --region us-east-1 route53domains get-domain-detail --domain-name $DOMAIN --query "Nameservers[0].Name" --output text)
export REGEX="^ns[1-4]\.titaniumvanguard\.co\.uk$"

if [[ $REG_NS =~ $REGEX ]]; then
	echo "Registrar nameservers are already set"
	exit 0
else
	aws route53domains --region us-east-1 update-domain-nameservers --cli-input-json file://test/integration/registrar.json
fi
