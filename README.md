# ar-ngxrealip
This script let you get the real IP address of your visitors for your web applications that behind of [ArvanCloud](https://www.arvancloud.com)'s CDN.
Bash script can be scheduled to create an automated up-to-date ArvanCloud IP list file.

For every request to the origin, ArvanCloud adds the [**AR_REAL_IP**](https://www.arvancloud.com/help/fa/article/360034320513-%DA%86%D9%87-%D8%B7%D9%88%D8%B1-%D9%85%DB%8C%20%D8%AA%D9%88%D8%A7%D9%86-%D8%A7%D8%B2-IP-%D9%88%D8%A7%D9%82%D8%B9%DB%8C-%DA%A9%D8%A7%D8%B1%D8%A8%D8%B1-%D9%86%D9%87%D8%A7%DB%8C%DB%8C-%D8%A2%DA%AF%D8%A7%D9%87-%D8%B4%D8%AF) header to provide the real client IP address. This script catch the header and get the real ip address of the visitor in the request header with real_ip_header directive.

## Prerequisites
You need the [Nginx installed](https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-open-source/#) (using official packages or binaries) with [ngx_http_realip_module](https://nginx.org/en/docs/http/ngx_http_realip_module.html) enabled.

Also you can check this with `nginx -V` command.

## Usage
All you need to have your real client IP addresses, is to `include /etc/nginx/arvancloud` inside the `http{....}` block of your Nginx configuration file. 
Then run the script manually or make it automatic by defining a cronjob.

## Output
Your "/etc/nginx/arvancloud" file may look like as below :

```sh
92.114.16.80/28
185.112.35.144/28
185.49.87.120/29
185.20.160.248/29
5.160.139.200/29
46.224.2.32/29
2.146.0.0/28
79.175.138.128/29
185.143.232.0/22
89.187.169.88/29
89.187.178.96/29
185.152.67.56/29
185.246.211.64/27
89.187.175.136/29
195.181.173.128/29
83.123.255.56/31
83.121.255.40/31
164.138.128.28/31
188.229.116.16/29
130.185.120.0/23
45.76.176.64/28
198.13.38.112/28
149.28.160.0/28
94.182.182.28/30
185.17.115.176/30
139.180.154.16/29
45.77.129.64/29
178.22.121.224/29
178.216.248.224/29
195.181.174.96/29
103.205.143.112/29
103.250.185.144/29
89.187.163.144/28
217.138.193.128/29
91.193.5.216/29
188.241.176.160/29
193.239.86.24/29
176.125.231.56/29
84.252.94.0/29
91.219.214.48/29
193.29.105.128/29
103.26.207.48/29
89.45.48.8/29
185.105.101.200/29

real_ip_header AR_REAL_IP;
```


## Useful Link
[ArvanCloud CDN Edge Servers IPs](https://www.arvancloud.com/fa/ips.txt)


## Crontab
Define a cronjob for the "/path/to/arvancloud-sync-ip-list.sh" script. ArvanCloud IP addresses are automatically refreshed at 2 AM & 14 PM every day, and nginx will be realoded when synchronization is completed.

# Auto sync ip addresses of Cloudflare and reload nginx
```sh
0 2,14 * * * /path/to/arvancloud-sync-ip-list.sh >/dev/null 2>&1
```

## License
[MIT license](https://github.com/ali-sefidmouy/ar-ngxrealip/blob/main/LICENSE)
