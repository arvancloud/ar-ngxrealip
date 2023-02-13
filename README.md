# Get Real Visitor IP Address (Restoring Visitor IPs) with Nginx and ArvanCloud
This project aims to modify your nginx configuration to let you get the real ip address of your visitors for your web applications that behind of ArvanCloud's reverse proxy network. Bash script can be scheduled to create an automated up-to-date ArvanCloud ip list file.

To provide the client (visitor) IP address for every request to the origin, ArvanCloud adds the "ar-real-ip" header. We will catch the header and get the real ip address of the visitor.

1. Create a bash script file in your desired location:
```sh
sudo nano /var/arvancloud-sync-ips-for-nginx.sh
```

2. Copy [arvancloud-sync-ips-for-nginx.sh](./arvancloud-sync-ips-for-nginx.sh)'s content and save the file:
```sh
#!/bin/bash

ARVANCLOUD_FILE_PATH=/etc/nginx/conf.d/arvancloud-set-real-ip.conf
ARVANCLOUD_CDN_IPS_TXT_URL="https://www.arvancloud.ir/fa/ips.txt"

VALID_IP_OCTET_REGEX="(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"
IP_WITH_SUBNET_REGEX="^$VALID_IP_OCTET_REGEX\.$VALID_IP_OCTET_REGEX\.$VALID_IP_OCTET_REGEX\.$VALID_IP_OCTET_REGEX\/[0-9]+$"
IP_ADDRS=$(curl -s -L $ARVANCLOUD_CDN_IPS_TXT_URL | grep -E -o "$IP_WITH_SUBNET_REGEX")

if [ -z "$IP_ADDRS" ];
then
  echo "Couldn't extract CDN any ip address from $ARVANCLOUD_CDN_IPS_TXT_URL"
  exit 1
fi

echo "#ArvanCloud" > $ARVANCLOUD_FILE_PATH;
echo "" >> $ARVANCLOUD_FILE_PATH;

echo "# - IPv4" >> $ARVANCLOUD_FILE_PATH;
for ip in $IP_ADDRS; do
  echo "set_real_ip_from $ip;" >> $ARVANCLOUD_FILE_PATH;
done

echo "" >> $ARVANCLOUD_FILE_PATH;
echo "real_ip_header ar-real-ip;" >> $ARVANCLOUD_FILE_PATH;

#test configuration and reload nginx
nginx -t && systemctl reload nginx

```
3. Set the proper permission for the file, so it can be executed:
```sh
sudo chmod 775 /var/arvancloud-sync-ips-for-nginx.sh
```
4. Now you can run the script manually to create the nginx config file:
```sh
sudo /var/arvancloud-sync-ips-for-nginx.sh
```

5. Or schedule a new cronjob to do it automatically on a regular intervals (e.g: every day at 2:30 a.m.)
```sh
sudo crontab -e
```
```sh
# Auto sync ip addresses of ArvanCloud and reload nginx
30 2 * * * /var/arvancloud-sync-ips-for-nginx.sh >/dev/null 2>&1
```
## Output
Now if you check `/etc/nginx/conf.d` directory you should see a new file named `arvancloud-set-real-ip.conf` which will be included to your nginx configs automatically and sets the real ip address for upcoming requests.
####
The output should be like below:

```nginx
#ArvanCloud

# - IPv4
set_real_ip_from 185.143.232.0/22;
set_real_ip_from 92.114.16.80/28;
set_real_ip_from 2.146.0.0/28;
set_real_ip_from 46.224.2.32/29;
set_real_ip_from 83.123.255.56/31;
set_real_ip_from 188.229.116.16/29;
set_real_ip_from 164.138.128.28/31;
set_real_ip_from 94.182.182.28/30;
set_real_ip_from 185.17.115.176/30;
set_real_ip_from 5.213.255.36/31;
set_real_ip_from 185.228.238.0/28;
set_real_ip_from 94.182.153.24/29;
set_real_ip_from 94.101.182.0/27;
set_real_ip_from 158.255.77.238/31;
set_real_ip_from 81.12.28.16/29;
set_real_ip_from 176.65.192.202/31;
set_real_ip_from 2.144.3.128/28;
set_real_ip_from 89.45.48.64/28;
set_real_ip_from 37.32.16.0/27;
set_real_ip_from 37.32.17.0/27;
set_real_ip_from 37.32.18.0/27;
set_real_ip_from 37.32.19.0/27;
set_real_ip_from 185.215.232.0/22;

real_ip_header ar-real-ip;
```
