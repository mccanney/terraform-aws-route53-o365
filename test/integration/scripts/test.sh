#! /bin/bash

export DOMAIN="tiguard.technology"
export NS="8.8.8.8"
export O365_MS=$(nslookup -type=txt $DOMAIN - $NS | grep -E "MS=ms.{9}$")
export EXCH_MX=$(nslookup -type=mx $DOMAIN - $NS | grep -E "\.mail\.protection\.outlook\.com\.$")
export EXCH_AUTO=$(nslookup -type=cname autodiscover.$DOMAIN - $NS | grep -E "autodiscover\.outlook\.com\.$")
export EXCH_SPF=$(nslookup -type=txt $DOMAIN - $NS | grep -E ".*protection\.outlook\.com..all.$")
export EXCH_DKIM1=$(nslookup -type=cname selector1._domainkey.$DOMAIN - $NS | grep -E "^selector1.*_domainkey.*\.onmicrosoft\.com\.$")
export EXCH_DKIM2=$(nslookup -type=cname selector2._domainkey.$DOMAIN - $NS | grep -E "^selector2.*_domainkey.*\.onmicrosoft\.com\.$")
export EXCH_DMARC=$(nslookup -type=txt _dmarc.$DOMAIN - $NS | grep -E "v=DMARC1.*")
export SFB_DIS=$(nslookup -type=cname lyncdiscover.$DOMAIN - $NS | grep -E "webdir\.online\.lync\.com\.$")
export SFB_SIP=$(nslookup -type=cname sip.$DOMAIN - $NS | grep -E "sipdir\.online\.lync\.com\.$")
export SFB_SIPDIR=$(nslookup -type=srv _sipfederationtls._tcp.$DOMAIN - $NS | grep -E "100.1.5061.sipfed\.online\.lync\.com\.$")
export SFB_SIPFED=$(nslookup -type=srv _sip._tls.$DOMAIN - $NS | grep -E "100.1.443.sipdir\.online\.lync\.com\.$")
export MDM_REG=$(nslookup -type=cname enterpriseregistration.$DOMAIN - $NS | grep -E "enterpriseregistration\.windows.net\.$")
export MDM_ENROL=$(nslookup -type=cname enterpriseenrollment.$DOMAIN - $NS | grep -E "enterpriseenrollment\.manage\.microsoft\.com\.$")

###################
# Office 365 MS TXT
###################

if [ -n "$O365_MS" ]; then
    echo "The MS TXT record is set correctly."
else
    echo "The MS TXT record is not set correctly."
    exit 1
fi

#############################
# Exchange Online DNS records
#############################

if [ -n "$EXCH_MX" ]; then
    echo "The MX record is set correctly."
else
    echo "The MX record is not set correctly."
    exit 1
fi

if [ -n "$EXCH_AUTO" ]; then
    echo "The e-mail autodiscover record is set correctly."
else
    echo "The e-mail autodiscover record is not set correctly."
    exit 1
fi

if [ -n "$EXCH_SPF" ]; then
    echo "The SPF record is set correctly."
else
    echo "The SPF record is not set correctly."
    exit 1
fi

if [ -n "$EXCH_DKIM1" ]; then
    echo "The DKIM1 record is set correctly."
else
    echo "The DKIM1 record is not set correctly."
    exit 1
fi

if [ -n "$EXCH_DKIM2" ]; then
    echo "The DKIM2 record is set correctly."
else
    echo "The DKIM2 record is not set correctly."
    exit 1
fi

if [ -n "$EXCH_DMARC" ]; then
    echo "The DMARC record is set correctly."
else
    echo "The DMARC record is not set correctly."
    exit 1
fi

################################
# Skype for Business DNS records
################################

if [ -n "$SFB_DIS" ]; then
    echo "The SFB discovery record is set correctly."
else
    echo "The SFB discovery record is not set correctly."
    exit 1
fi

if [ -n "$SFB_SIP" ]; then
    echo "The SFB sip record is set correctly."
else
    echo "The SFB sip record is not set correctly."
    exit 1
fi

if [ -n "$SFB_SIPDIR" ]; then
    echo "The SFB service record is set correctly."
else
    echo "The SFB service record is not set correctly."
    exit 1
fi

if [ -n "$SFB_SIPFED" ]; then
    echo "The SFB federation record is set correctly."
else
    echo "The SFB federation record is not set correctly."
    exit 1
fi

######################################
# Mobile Device Management DNS records
######################################

if [ -n "$MDM_REG" ]; then
    echo "The MDM registration record is set correctly."
else
    echo "The MDM registration is not set correctly."
    exit 1
fi

if [ -n "$MDM_ENROL" ]; then
    echo "The MDM enrollment record is set correctly."
else
    echo "The MDM enrollment record is not set correctly."
    exit 1
fi
