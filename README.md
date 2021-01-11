# ar-ngxrealip
ArvanCloud User Real IP in Nginx

# Brief
Show Real IPs instead of Arvan IPs in Nginx

## Nginx Configuration
In your nginx configuration file add the Following line:
```
include /etc/nginx/arvan_white_list.conf
```
# Output 
Your file will be similar as below

```
set_real_ip_from 92.114.16.80/28 ;
set_real_ip_from 185.112.35.144/28 ;
set_real_ip_from 185.49.87.120/29 ;
set_real_ip_from 185.20.160.248/29 ;
set_real_ip_from 5.160.139.200/29 ;
set_real_ip_from 46.224.2.32/29 ;
set_real_ip_from 2.146.0.0/28 ;
set_real_ip_from 79.175.138.128/29 ;
set_real_ip_from 185.143.232.0/22 ;
set_real_ip_from 89.187.169.88/29 ;
set_real_ip_from 89.187.178.96/29 ;
set_real_ip_from 185.152.67.56/29 ;
```

# Auto Renewal
Add the following line into your crontab
```
0 0 * * * /{path_to_getip_script}/getip.sh >/dev/null 2>&1
```
