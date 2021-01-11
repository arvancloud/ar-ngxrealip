#!/bin/bash

ARVAN_FILE_PATH=/etc/nginx/arvan

echo "#Arvan Cloud CDN ip addresses" > $ARVAN_FILE_PATH;
echo "" >> $ARVAN_FILE_PATH;

echo "# - IPv4" >> $ARVAN_FILE_PATH;
arvan_ip_list=`curl https://www.arvancloud.com/fa/ips.txt`
if [[ $? == 0 ]]
then  
    for ip in $arvan_ip_list; do
        echo "set_real_ip_from $ip;" >> $ARVAN_FILE_PATH;
    done
    echo "real_ip_header ar-real-ip;" >> $ARVAN_FILE_PATH;
fi


#test configuration and reload nginx
nginx -t && systemctl reload nginx
