#!/bin/bash

# Initialize Kubernetes master
echo "Initializing Kubernetes master..."
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.56.10 --ignore-preflight-errors=NumCPU

# Configure kubectl for the vagrant user
echo "Configuring kubectl for vagrant user..."
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install Flannel Pod Network Add-on
echo "Installing Flannel CNI..."
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

echo "Master node provisioning complete."