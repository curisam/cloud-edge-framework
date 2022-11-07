ansible -i hosts.ini rpi -m setup --tree tmp.0/
ansible -i hosts.ini server -m setup --tree tmp.0/
