#!/bin/bash

ARVANCLOUD_FILE_PATH=/etc/nginx/arvancloud

echo "#Arvan" > $ARVANCLOUD_FILE_PATH;
echo "" >> $ARVANCLOUD_FILE_PATH;

echo "# - IPv4" >> $ARVANCLOUD_FILE_PATH;
for i in `curl https://www.arvancloud.com/fa/ips.txt`; do
        echo "set_real_ip_from $i;" >> $ARVANCLOUD_FILE_PATH;
done

echo "" >> $ARVANCLOUD_FILE_PATH;
echo "real_ip_header ar-real-ip;" >> $ARVANCLOUD_FILE_PATH;

#test configuration and reload nginx
nginx -t && systemctl reload nginx
