# Get Real Visitor IP Address (Restoring Visitor IPs) with Nginx and ArvanCloud
This project aims to modify your nginx configuration to let you get the real ip address of your visitors for your web applications that behind of ArvanCloud's reverse proxy network. Bash script can be scheduled to create an automated up-to-date ArvanCloud ip list file.

To provide the client (visitor) IP address for every request to the origin, ArvanCloud adds the "ar-real-ip" header. We will catch the header and get the real ip address of the visitor.

## Nginx Configuration
With a small configuration modification we can integrate replacing the real ip address of the visitor instead of getting ArvanCloud's load balancers' ip addresses.

Open "/etc/nginx/nginx.conf" file with your favorite text editor and just add the following lines to your nginx.conf inside http{....} block.

```nginx
include /etc/nginx/arvancloud;
```

The bash script may run manually or can be scheduled to refresh the ip list of ArvanCloud automatically.
```sh
#!/bin/bash

ARVANCLOUD_FILE_PATH=/etc/nginx/arvancloud

echo "#ArvanCloud" > $ARVANCLOUD_FILE_PATH;
echo "" >> $ARVANCLOUD_FILE_PATH;

echo "# - IPv4" >> $ARVANCLOUD_FILE_PATH;
for i in `curl https://www.arvancloud.com/fa/ips.txt`; do
    echo "set_real_ip_from $i;" >> $ARVANCLOUD_FILE_PATH;
done

echo "" >> $ARVANCLOUD_FILE_PATH;
echo "real_ip_header ar-real-ip;" >> $ARVANCLOUD_FILE_PATH;

#test configuration and reload nginx
nginx -t && systemctl reload nginx
```

## Output
Your "/etc/nginx/arvancloud" file may look like as below;

```nginx
#ArvanCloud ip addresses

# - IPv4
set_real_ip_from 92.114.16.80/28;
set_real_ip_from 185.112.35.144/28;
set_real_ip_from 185.49.87.120/29;
set_real_ip_from 185.20.160.248/29;
set_real_ip_from 5.160.139.200/29;
set_real_ip_from 46.224.2.32/29;
set_real_ip_from 2.146.0.0/28;
set_real_ip_from 79.175.138.128/29;
set_real_ip_from 185.143.232.0/22;
set_real_ip_from 89.187.169.88/29;
set_real_ip_from 89.187.178.96/29;
set_real_ip_from 185.152.67.56/29;
set_real_ip_from 185.246.211.64/27;
set_real_ip_from 89.187.175.136/29;
set_real_ip_from 195.181.173.128/29;
set_real_ip_from 83.123.255.56/31;
set_real_ip_from 83.121.255.40/31;
set_real_ip_from 164.138.128.28/31;
set_real_ip_from 188.229.116.16/29;
set_real_ip_from 130.185.120.0/23;
set_real_ip_from 45.76.176.64/28;
set_real_ip_from 198.13.38.112/28;
set_real_ip_from 149.28.160.0/28;
set_real_ip_from 94.182.182.28/30;
set_real_ip_from 185.17.115.176/30;
set_real_ip_from 139.180.154.16/29;
set_real_ip_from 45.77.129.64/29;
set_real_ip_from 178.22.121.224/29;
set_real_ip_from 178.216.248.224/29;
set_real_ip_from 195.181.174.96/29;
set_real_ip_from 103.205.143.112/29;
set_real_ip_from 103.250.185.144/29;
set_real_ip_from 89.187.163.144/28;
set_real_ip_from 217.138.193.128/29;
set_real_ip_from 91.193.5.216/29;
set_real_ip_from 188.241.176.160/29;
set_real_ip_from 193.239.86.24/29;
set_real_ip_from 176.125.231.56/29;
set_real_ip_from 84.252.94.0/29;
set_real_ip_from 91.219.214.48/29;
set_real_ip_from 193.29.105.128/29;
set_real_ip_from 103.26.207.48/29;
set_real_ip_from 89.45.48.8/29;
set_real_ip_from 185.105.101.200/29;

real_ip_header ar-real-ip;

```

## Crontab
Change the location of "/opt/scripts/arvancloud-ip-whitelist-sync.sh" anywhere you want. 
ArvanCloud ip addresses are automatically refreshed every day, and nginx will be realoded when synchronization is completed.
```sh
# Auto sync ip addresses of ArvanCloud and reload nginx
30 2 * * * /opt/scripts/arvancloud-ip-whitelist-sync.sh >/dev/null 2>&1
```
