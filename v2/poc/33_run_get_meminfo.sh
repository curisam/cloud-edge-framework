ansible rpi -m shell -a "sudo cat /proc/meminfo" -i hosts.ini 
ansible server -m shell -a "sudo cat /proc/meminfo" -i hosts.ini 
