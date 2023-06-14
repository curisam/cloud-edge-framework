#ansible all  -m shell -a "speedtest-cli" -i hosts.ini 
ansible all  -m shell -a "speedtest-cli --mini http://keticmr.iptime.org:22809" -i ../config/hosts.ini 
