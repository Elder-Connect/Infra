sudo apt update
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d api.elderly.space -d www.api.elderly.space
sudo certbot --nginx -d elderly.space -d www.elderly.space