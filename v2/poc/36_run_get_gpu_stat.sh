# http://keticmr.iptime.org:22809

# <ubuntu> 
# $ sudo apt install speedtest-cli

# <rpi> 
# $ sudo pip3 install speedtest-cli

ansible server -m shell -a "gpustat" -i hosts.ini   --ask-become-pass
