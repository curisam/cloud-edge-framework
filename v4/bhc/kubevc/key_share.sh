ARR=()

while true; do
    read -p "Enter the UserName of the Worker node(If you want to quit, enter 0): " NODE_USERNAME
    if [[ "$NODE_USERNAME" == "0" ]]; then
        break
    fi
    read -p "Enter the Public IP Address of the Worker node: " NODE_PUBLIC_IP
    read -p "Enter the SSH Port of the Worker node: " NODE_SSH_PORT
    ARR+=("$NODE_USERNAME@$NODE_PUBLIC_IP")
done

for node in "${ARR[@]}"; do
    ssh-copy-id $node
done
