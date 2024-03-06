#!/bin/bash

ARCH=$(dpkg -s libc6 | grep Architecture | awk '{print $2}')

DOWNLOAD_DIR="/tmp"
INSTALL_DIR="/usr/local/bin"

RELEASE_CONTAINERD="1.7.2"
RELEASE_CRICTL="1.27.1"
RELEASE_KUBEADM="v1.27.3"
RELEASE_KUBELET="v0.15.1"
RELEASE_K3S="v1.27.3+k3s1"
RELEASE_RUNC="v1.1.9"

echo -e "### Setting up Kubernetes environments ###"

# change working directory to tmp
cd /tmp

# install helm
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash > /dev/null 2>&1

# download Containerd
echo -e "\n[Downloading] Containerd"
wget -q "https://github.com/containerd/containerd/releases/download/v$RELEASE_CONTAINERD/containerd-$RELEASE_CONTAINERD-linux-$ARCH.tar.gz" > /dev/null 2>&1

# unzip
sudo tar -C /usr/local -xzf "containerd-$RELEASE_CONTAINERD-linux-$ARCH.tar.gz"
sudo rm -rf "containerd-$RELEASE_CONTAINERD-linux-$ARCH.tar.gz"

# generate Containerd configuration
sudo mkdir -p /etc/containerd/
containerd config default | sudo tee /etc/containerd/config.toml > /dev/null 2>&1

# activate SystemdCgroup about Containerd
echo -e "\n[Modifying] Containerd to use System Cgroups"
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml

# download systemd sevice file for Containerd
sudo curl -sSL https://raw.githubusercontent.com/containerd/containerd/main/containerd.service -o /etc/systemd/system/containerd.service

# reload systemd
sudo systemctl daemon-reload 

# start and activate Containerd service
echo -e "\n[Activating] Containerd Service"
sudo systemctl enable --now containerd > /dev/null 2>&1

# download binary file of crictl
echo -e "\n[Downloading] Crictl"
wget -q "https://github.com/kubernetes-sigs/cri-tools/releases/download/v$RELEASE_CRICTL/crictl-v$RELEASE_CRICTL-linux-$ARCH.tar.gz"

# unzip 
sudo tar zxf "crictl-v$RELEASE_CRICTL-linux-$ARCH.tar.gz" -C /usr/local/bin
rm -f "crictl-v$RELEASE_CRICTL-linux-$ARCH.tar.gz"

# set endpoints to crictl
cat <<EOF | sudo tee /etc/crictl.yaml  > /dev/null 2>&1
runtime-endpoint: unix:///run/containerd/containerd.sock
image-endpoint: unix:///run/containerd/containerd.sock
EOF

# add br_netfilter to /etc/modules
echo -e "\n[Adding] br_netfilter to modules"
echo br_netfilter | sudo tee -a /etc/modules  > /dev/null 2>&1

# activate br_netfilter
echo -e "\n[Activating] br_netfilter"
sudo modprobe br_netfilter

# install socat and conntrack
sudo apt update > /dev/null 2>&1
echo -e "\n[Installing] socat and conntrack" 
sudo apt install -y socat conntrack git unzip nfs-common > /dev/null 2>&1
sudo apt clean  

# install runc
echo -e "\n[Installing] runc"
wget https://github.com/opencontainers/runc/releases/download/$RELEASE_RUNC/runc.$ARCH > /dev/null 2>&1
mv runc.$ARCH runc 
chmod +x runc 
sudo mv runc /usr/local/bin/ 

# edit sysctl settings 
echo "net.bridge.bridge-nf-call-ip6tables = 1" | sudo tee -a /etc/sysctl.conf  > /dev/null 2>&1
echo "net.bridge.bridge-nf-call-iptables = 1" | sudo tee -a /etc/sysctl.conf  > /dev/null 2>&1
echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf  > /dev/null 2>&1
echo "net.ipv6.conf.all.forwarding = 1" | sudo tee -a /etc/sysctl.conf  > /dev/null 2>&1

# apply sysctl settings
sudo sysctl -p > /dev/null 2>&1  

# deactivate memory swap
echo -e "\n[Deactivate] Memory Swap"
sudo sed -i '/ swap / s/^/#/' /etc/fstab
sudo swapoff -a

# enable systemd-resolved
sudo systemctl enable --now systemd-resolved   > /dev/null 2>&1

# cgroup memory setting
echo -e "\n[Setting] Memory Cgroup"
if [ -d "/boot/grub" ] ; then
    sudo sed -i 's/^GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX="cgroup_enable=memory cgroup_memory=1"/' /etc/default/grub

    # update grub setting
    sudo update-grub > /dev/null 2>&1

    # permanently swap-off 
    unit_files=$(systemctl list-unit-files --type swap --no-legend | awk '{print $1}')
    for unit in $unit_files; do
    if [[ $unit == *".swap" ]]; then
        sudo systemctl mask $unit
    fi
    done
    
else 
    sudo sed -i 's/rootwait/rootwait cgroup_memory=1 cgroup_enable=memory/g' /boot/cmdline.txt

    # permanently swap-off
    sudo systemctl disable --now dphys-swapfile.service
fi

echo -en "\nWhich Kubernetes distribution type do you want to install?\n1. k8s\n2. k3s\n> "
while true; do
    read TYPE

    if [ "${TYPE^^}" = "1" ] || [ "${TYPE^^}" = "K8S" ]; then
        TYPE=1
        break
    elif [ "${TYPE^^}" = "2" ] || [ "${TYPE^^}" = "K3S" ]; then
        TYPE=2
        break
    else
        echo -e "\n[Wrong Input]: Please try again "
    fi
done

if [ $TYPE -eq 1 ]; then
    # Set directory for download resources
    sudo mkdir -p "$DOWNLOAD_DIR"

    # crictl must be installed before next steps.
    # install kubeadm, kubelet and kubelet service
    cd $DOWNLOAD_DIR
    sudo curl -sSL --remote-name-all https://dl.k8s.io/release/${RELEASE_KUBEADM}/bin/linux/${ARCH}/kubeadm
    sudo curl -sSL --remote-name-all https://dl.k8s.io/release/${RELEASE_KUBEADM}/bin/linux/${ARCH}/kubelet
    sudo cp $DOWNLOAD_DIR/kubeadm $DOWNLOAD_DIR/kubelet $INSTALL_DIR/
    sudo install -o root -g root -m 0755 kubeadm /usr/local/bin/kubeadm && echo -e "\n[Installing] Kubeadm"
    sudo install -o root -g root -m 0755 kubelet /usr/local/bin/kubelet && echo -e "\n[Installing] Kubelet"
    
    curl -sSL "https://raw.githubusercontent.com/kubernetes/release/${RELEASE_KUBELET}/cmd/kubepkg/templates/latest/deb/kubelet/lib/systemd/system/kubelet.service" | sed "s:/usr/bin:${INSTALL_DIR}:g" | sudo tee /etc/systemd/system/kubelet.service > /dev/null 2>&1
    sudo mkdir -p /etc/systemd/system/kubelet.service.d
    curl -sSL "https://raw.githubusercontent.com/kubernetes/release/${RELEASE_KUBELET}/cmd/kubepkg/templates/latest/deb/kubeadm/10-kubeadm.conf" | sed "s:/usr/bin:${INSTALL_DIR}:g" | sudo tee /etc/systemd/system/kubelet.service.d/10-kubeadm.conf > /dev/null 2>&1

    echo -e "\n[Installing] Kubectl"
    sudo curl -sSL -O "https://dl.k8s.io/release/${RELEASE_KUBEADM}/bin/linux/${ARCH}/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

    # enable and start kubelet as service
    echo -e "\n[Starting] Kubectl as a service"
    sudo systemctl enable --now kubelet  > /dev/null 2>&1
fi

echo -e "\n\n### Environment setup successfully complete! ###"

# suggest reboot
echo -en "\nRestart required: Do you want to restart your system now? (y/n)\n> "
while true; do
    read ANSWER

    if [ "${ANSWER^^}" = "Y" ] || [ "${ANSWER^^}" = "YES" ]; then
        sudo reboot && echo "[Rebooting...]"
        break
    elif [ "${ANSWER^^}" = "N" ] || [ "${ANSWER^^}" = "NO" ]; then
        echo ""
        break
    else
        echo -e "\n[Wrong Input]: Please try again "
    fi
done