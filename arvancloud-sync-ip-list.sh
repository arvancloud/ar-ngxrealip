#!/bin/bash

ARVANCLOUD_FILE_PATH=/etc/nginx/arvancloud

echo "#ArvanCloud" > $ARVANCLOUD_FILE_PATH;
echo "" >> $ARVANCLOUD_FILE_PATH;

echo "# - IPv4" >> $ARVANCLOUD_FILE_PATH;
for u in `curl -s https://www.arvancloud.com/fa/ips.txt`; do
        echo "set_real_ip_from $u;" >> $ARVANCLOUD_FILE_PATH;
done

echo "" >> $ARVANCLOUD_FILE_PATH;
echo "real_ip_header AR_REAL_IP;" >> $ARVANCLOUD_FILE_PATH;

#test configuration and reload nginx
nginx -t && systemctl reload nginx