ansible rpi -m shell -a "sudo cat /proc/cpuinfo" -i hosts.ini
ansible server -m shell -a "sudo cat /proc/cpuinfo" -i hosts.ini
