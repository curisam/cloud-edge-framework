ansible server -m shell -a "sensors" -i hosts.ini 
ansible rpi -m shell -a "sudo cat /sys/class/thermal/thermal_zone0/temp" -i hosts.ini 
