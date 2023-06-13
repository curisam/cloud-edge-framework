ansible rpi -m shell -a "sudo apt update; curl -fsSL https://get.docker.com -o get-docker.sh; sudo bash get-docker.sh; sudo usermod -aG docker $(whoami);" -i hosts.ini
