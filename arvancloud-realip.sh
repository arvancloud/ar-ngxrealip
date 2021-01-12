#!/bin/bash

AR_FILE_PATH=/etc/nginx/arvancloud_ips

# Sudo access needed
if [[ $EUID -ne 0 ]]; then
	echo "You need to run this as root"
	exit 1
fi

echo "# ArvanCloud IPs list" > $AR_FILE_PATH;
echo "" >> $AR_FILE_PATH;

for i in $(curl -s https://www.arvancloud.com/fa/ips.txt); do
    echo "set_real_ip_from $i;" >> $AR_FILE_PATH;
done

echo "" >> $AR_FILE_PATH;
echo "real_ip_header AR-Real-IP;" >> $AR_FILE_PATH;

# test configuration and reload nginx
nginx -t && systemctl reload nginx
