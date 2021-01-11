# ar-ngxrealip
*Get Real Visitor IP Address (Restoring Visitor IPs) with Nginx and ArvanCloud.*

This project aims to modify your nginx configuration to let you get the real ip address of your visitors for your web applications that behind of ArvanCloud's reverse proxy network. Bash script can be scheduled to create an automated up-to-date ArvanCloud ip list file.

To provide the client (visitor) IP address for every request to the origin, ArvanCloud adds the "[AR-Real-IP](https://www.arvancloud.com/help/fa/article/360013052279-%D9%87%D8%AF%D8%B1%D9%87%D8%A7%DB%8C-%D8%A7%D8%B1%D8%B3%D8%A7%D9%84%DB%8C-%D8%A8%D9%87-%D8%B3%D9%85%D8%AA-%DA%A9%D8%A7%D8%B1%D8%A8%D8%B1-%D9%88-%D8%B3%D8%B1%D9%88%D8%B1-%D8%A7%D8%B5%D9%84%DB%8C-%D9%87%D9%86%DA%AF%D8%A7%D9%85-%D8%A7%D8%B3%D8%AA%D9%81%D8%A7%D8%AF%D9%87-%D8%A7%D8%B2-%E2%80%8FCDN%E2%80%8F-%D8%A7%D8%A8%D8%B1-%D8%A2%D8%B1%D9%88%D8%A7%D9%86)" header. We will catch the header and get the real ip address of the visitor.

## Nginx Configuration
With a small configuration modification we can integrate replacing the real ip address of the visitor instead of getting ArvanCloud's load balancers' ip addresses.

Open "/etc/nginx/nginx.conf" file with your favorite text editor and just add the following lines to your nginx.conf inside http{....} block.

```nginx
include /etc/nginx/ar-ngxrealip;
```

The bash script may run manually or can be scheduled to refresh the ip list of ArvanCloud automatically.
```sh
#!/bin/bash

AR_NGXREALIP_CONFIG_PATH=/etc/nginx/ar-ngxrealip

echo "# ArvanCloud CDN Servers IPs" > $AR_NGXREALIP_CONFIG_PATH;
echo "" >> $AR_NGXREALIP_CONFIG_PATH;

for i in `curl -s https://www.arvancloud.com/fa/ips.txt`; do
    echo "set_real_ip_from $i;" >> $AR_NGXREALIP_CONFIG_PATH;
done

echo "" >> $AR_NGXREALIP_CONFIG_PATH;
echo "real_ip_header AR-REAL-IP;" >> $AR_NGXREALIP_CONFIG_PATH;

#test configuration and reload nginx
nginx -t && systemctl reload nginx
```

## Output
Your "/etc/nginx/ar-ngxrealip" file may look like as below;

```nginx
# ArvanCloud CDN Servers IPs

set_real_ip_from 92.114.16.80/28;
set_real_ip_from 185.112.35.144/28;
set_real_ip_from 185.49.87.120/29;
set_real_ip_from 185.20.160.248/29;
set_real_ip_from 5.160.139.200/29;
set_real_ip_from 46.224.2.32/29;
set_real_ip_from 2.146.0.0/28;

real_ip_header AR-Real-IP;
```

## Crontab
Change the location of "/opt/scripts/ar-sync-ips.sh" anywhere you want. 
ArvanCloud ip addresses are automatically refreshed every day, and nginx will be reloaded when synchronization is completed.
```sh
# Auto sync ip addresses of ArvanCloud and reload nginx
30 2 * * * /opt/scripts/ar-sync-ips.sh >/dev/null 2>&1
```

### License

[Apache 2.0](http://www.apache.org/licenses/LICENSE-2.0)


### DISCLAIMER
----------
Please note: all tools/ scripts in this repo are released for use "AS IS" **without any warranties of any kind**,
including, but not limited to their installation, use, or performance.  We disclaim any and all warranties, either 
express or implied, including but not limited to any warranty of noninfringement, merchantability, and/ or fitness 
for a particular purpose.  We do not warrant that the technology will meet your requirements, that the operation 
thereof will be uninterrupted or error-free, or that any errors will be corrected.

Any use of these scripts and tools is **at your own risk**.  There is no guarantee that they have been through 
thorough testing in a comparable environment and we are not responsible for any damage or data loss incurred with 
their use.

You are responsible for reviewing and testing any scripts you run *thoroughly* before use in any non-testing 
environment.

Thanks,   
[Ergin BULUT](https://www.erginbulut.com)

---
## Reference
- [ArvanCloud CDN Headers](https://www.arvancloud.com/help/fa/article/360013052279-%D9%87%D8%AF%D8%B1%D9%87%D8%A7%DB%8C-%D8%A7%D8%B1%D8%B3%D8%A7%D9%84%DB%8C-%D8%A8%D9%87-%D8%B3%D9%85%D8%AA-%DA%A9%D8%A7%D8%B1%D8%A8%D8%B1-%D9%88-%D8%B3%D8%B1%D9%88%D8%B1-%D8%A7%D8%B5%D9%84%DB%8C-%D9%87%D9%86%DA%AF%D8%A7%D9%85-%D8%A7%D8%B3%D8%AA%D9%81%D8%A7%D8%AF%D9%87-%D8%A7%D8%B2-%E2%80%8FCDN%E2%80%8F-%D8%A7%D8%A8%D8%B1-%D8%A2%D8%B1%D9%88%D8%A7%D9%86)
- [ArvanCloud CDN Edge Servers IPs](https://www.arvancloud.com/fa/ips.txt)
- [Original CloudFlare tool](https://github.com/ergin/nginx-cloudflare-real-ip)
