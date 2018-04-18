#! /bin/bash

export DOMAIN="tiguard.technology"
export NS="8.8.8.8"
export MX_RECORD=$(nslookup -type=mx $DOMAIN - $NS | grep -E "\.mail\.protection\.outlook\.com\.$")
export MAIL_AUTO=$(nslookup -type=cname autodiscover.$DOMAIN - $NS | grep -E "autodiscover\.outlook\.com\.$")

if [ -n "$MX_RECORD" ]; then
    echo "The MX record is set correctly."
else
    echo "The MX record is not set correctly."
    exit 1
fi

if [ -n "$MAIL_AUTO" ]; then
    echo "The e-mail autodiscover record is set correctly."
else
    echo "The e-mail autodiscover record is not set correctly."
    exit 1
fi