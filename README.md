# Get Real Visitor IP Address (Restoring Visitor IPs) with Nginx and Arvan Cloud CDN
This project aims to modify your nginx configuration to let you get the real ip address of your visitors for your web applications that are behind Arvan Cloud's reverse proxy network. Bash script can be scheduled to create an automated up-to-date Arvan Cloud ip list file.

To provide the client (visitor) IP address for every request to the origin, Arvan Cloud adds the "ar-real-ip" header. We will catch the header and get the real ip address of the visitor.

## Nginx Configuration
Open "/etc/nginx/nginx.conf" file with your favorite text editor and just add the following lines to your nginx.conf inside http{....} block.

```nginx
include /etc/nginx/arvan;
```

The bash script may run manually or can be scheduled to refresh the ip list of Arvan Cloud automatically.

## Output
If the response is received successfully, your "/etc/nginx/arvan" file may look like as below

```nginx
#Arvan Cloud CDN ip addresses

# - IPv4
set_real_ip_from 92.114.16.80/28;
set_real_ip_from 185.112.35.144/28;
set_real_ip_from 185.49.87.120/29;
...
set_real_ip_from 185.105.101.200/29;
real_ip_header ar-real-ip;

```

## Crontab
Change the location of "/opt/scripts/arvan-real-ip.sh" anywhere you want. 
Also change the path to your script in crontab accordingly. 
```sh
# Auto sync ip addresses of Cloudflare and reload nginx
30 2 * * * /opt/scripts/arvan-real-ip.sh >/dev/null 2>&1
```

