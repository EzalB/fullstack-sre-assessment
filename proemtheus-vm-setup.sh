sudo apt update
sudo apt install prometheus prometheus-node-exporter nginx apache2-utils
sudo apt install prometheus-node-exporter
sudo htpasswd -c /etc/nginx/.htpasswd admin

sudo nano /etc/nginx/sites-available/prometheus

server {
    listen 80;
    server_name _;

    auth_basic "Protected Metrics";
    auth_basic_user_file /etc/nginx/.htpasswd;

    location / {
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_pass http://localhost:9090;
    }

    location /metrics/ {
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_pass http://localhost:9100/;
    }
}

sudo ln -s /etc/nginx/sites-available/prometheus /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default

sudo nginx -t
sudo systemctl reload nginx

sudo ufw allow 22
sudo ufw allow 80
sudo ufw deny 9090
sudo ufw deny 9100

sudo ufw enable

sudo ufw status

sudo nano /etc/prometheus/

Add config for external-node-exporter under scrape_configs: