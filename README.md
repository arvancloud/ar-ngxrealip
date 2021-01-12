# ar-ngxrealip

This project modifies your Nginx configuration to let you get the real IP address of your visitors for your web applications behind Arvancloud's reverse proxy network.

Also, The bash script can be scheduled to create an automated up-to-date IP list file.

#### How it works

To provide the client IP address for every request to the origin, ArvanCloud adds the "AR-Real-IP" header. We will catch the header and get the real IP Address of the client.

## Requirements

* Nginx with [ngx_http_realip_module](https://nginx.org/en/docs/http/ngx_http_realip_module.html) enabled
* curl

## How to use

1. add below line to your Nginx configuration file  
```include /etc/nginx/arvancloud_ips;```
2. Run the script

#### Auto-update

You can add a cronjob to update the IPs list automatically.

```sh
# update the list every 6 hours
0 */6 * * * /path/to/arvancloud-realip.sh >/dev/null 2>&1
```
