#!/bin/bash


nginx_config_path='/etc/nginx'

IP=$(curl https://www.arvancloud.com/en/ips.txt)

for i in $IP
do
echo "set_real_ip_from $i ;" >> $nginx_config_path/arvan_white_list.conf
done

nginx -t && systemctl reload nginx
