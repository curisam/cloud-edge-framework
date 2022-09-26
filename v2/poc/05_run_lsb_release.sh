ansible server -m shell -a "lsb_release -a" -i hosts.ini 
ansible rpi -m shell -a "lsb_release -a" -i hosts.ini 
