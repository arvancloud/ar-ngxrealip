#!/bin/bash

ARVANCLOUD_FILE_PATH=/etc/nginx/arvancloud
ARVANCLOUD_CDN_IPS_TXT_URL="https://www.arvancloud.com/fa/ips.txt"

VALID_IP_OCTET_REGEX="(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"
IP_WITH_SUBNET_REGEX="^$VALID_IP_OCTET_REGEX\.$VALID_IP_OCTET_REGEX\.$VALID_IP_OCTET_REGEX\.$VALID_IP_OCTET_REGEX\/[0-9]+$"
IP_ADDRS=$(curl -s -L $ARVANCLOUD_CDN_IPS_TXT_URL | grep -E -o "$IP_WITH_SUBNET_REGEX")

if [ -z "$IP_ADDRS" ];
then
  echo "Couldn't extract CDN any ip address from $ARVANCLOUD_CDN_IPS_TXT_URL"
  exit 1
fi

echo "#Arvan" > $ARVANCLOUD_FILE_PATH;
echo "" >> $ARVANCLOUD_FILE_PATH;

echo "# - IPv4" >> $ARVANCLOUD_FILE_PATH;
for ip in $IP_ADDRS; do
  echo "set_real_ip_from $ip;" >> $ARVANCLOUD_FILE_PATH;
done

echo "" >> $ARVANCLOUD_FILE_PATH;
echo "real_ip_header ar-real-ip;" >> $ARVANCLOUD_FILE_PATH;

#test configuration and reload nginx
nginx -t && systemctl reload nginx
