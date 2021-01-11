#!/bin/bash

AR_NGXREALIP_CONFIG_PATH=/etc/nginx/ar-ngxrealip

echo "# ArvanCloud CDN" > $AR_NGXREALIP_CONFIG_PATH;
echo "" >> $AR_NGXREALIP_CONFIG_PATH;

for i in `curl -s https://www.arvancloud.com/fa/ips.txt`; do
    echo "set_real_ip_from $i;" >> $AR_NGXREALIP_CONFIG_PATH;
done

echo "" >> $AR_NGXREALIP_CONFIG_PATH;
echo "real_ip_header AR-REAL-IP;" >> $AR_NGXREALIP_CONFIG_PATH;

#test configuration and reload nginx
nginx -t && systemctl reload nginx
