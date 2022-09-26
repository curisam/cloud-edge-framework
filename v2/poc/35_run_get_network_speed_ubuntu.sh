# http://keticmr.iptime.org:22809

# <ubuntu> 
# $ sudo apt install speedtest-cli

# <rpi> 
# $ sudo pip3 install speedtest-cli

ansible server -m shell -a "speedtest-cli --secure --mini http://keticmr.iptime.org:22809" -i hosts.ini   --ask-become-pass
