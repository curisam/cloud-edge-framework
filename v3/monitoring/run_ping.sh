ansible mac -m ping -i ../config/hosts.ini 
ansible rpi -m ping -i ../config/hosts.ini 
ansible server -m ping -i ../config/hosts.ini 
ansible worker -m ping -i ../config/hosts.ini 
ansible jetson -m ping -i ../config/hosts.ini 
