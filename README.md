# ArvanCloud Real Visitor IP

![logo](.github/logo.svg)

This project aims to modify your Nginx configuration to let you get the actual IP address of your visitors for your web applications that are behind of ArvanCloud’s reverse proxy network. You can schedule this bash script to create an automated up-to-date ArvanCloud IP list file.

To provide the client (visitor) IP address for every request to the origin, ArvanCloud adds the “ar-real-ip” header. We will catch the header and get the actual IP address of the visitor.

1. Create a bash script file in your desired location:

   ```bash
   sudo nano /var/arvancloud-sync-ips-for-nginx.sh
   ```

2. Copy [arvancloud-sync-ips-for-nginx.sh](./arvancloud-sync-ips-for-nginx.sh)'s content and save the file.

3. Set the proper permission for the file so it can be executed:

   ```bash
   sudo chmod 775 /var/arvancloud-sync-ips-for-nginx.sh
   ```

4. Now you can run the script manually to create the Nginx config file:

   ```bash
   sudo /var/arvancloud-sync-ips-for-nginx.sh
   ```

5. Or schedule a new cronjob to do it automatically at regular intervals (e.g: every day at 2:30 a.m.)

   ```sh
   sudo crontab -e

   # Auto sync IP addresses of ArvanCloud and reload the Nginx
   30 2 * * * /var/arvancloud-sync-ips-for-nginx.sh >/dev/null 2>&1
   ```

## Output

Now if you check `/etc/nginx/conf.d` directory you should see a new file named `arvancloud-set-real-ip.conf` which will be included in your Nginx configs automatically and sets the actual IP address for upcoming requests.

The output should be like the below:

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
