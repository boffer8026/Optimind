sudo cp /home/forge/getoptimind.com/config/supervisor/rc.local /etc/rc.local
sudo chmod +x /etc/rc.local
sudo supervisorctl reread
sudo supervisorctl add queue