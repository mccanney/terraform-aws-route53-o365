#!/bin/bash

export PATH=$PATH:~/.local/bin
export DOMAIN="tiguard.technology"
export ZONE_ID=$(aws route53 list-hosted-zones-by-name --dns-name $DOMAIN --query "HostedZones[0].Id" --output text)
export NS=$(aws route53 list-resource-record-sets --hosted-zone-id $ZONE_ID --query "ResourceRecordSets[?Type=='NS'].ResourceRecords[0].Value" --output text)
export REGEX="^ns[1-4]\.titaniumvanguard\.co\.uk\.$"

if [[ $NS =~ $REGEX ]]; then
	echo "Nameservers are already set"
	exit 0
else
	aws route53 change-resource-record-sets --hosted-zone-id $ZONE_ID --change-batch file://test/integration/nameservers.json
fi
