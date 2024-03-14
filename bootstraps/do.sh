sudo hostnamectl set-hostname dif-per-vm

sudo systemctl enable --now sshd

sudo yum update

sudo swapoff -a
sudo yum remove zram-generator-defaults


# required for kubeadm
sudo dnf install -y iproute-tc
sudo firewall-cmd --permanent --add-port=6443/tcp
sudo firewall-cmd --permanent --add-port=10250/tcp
sudo firewall-cmd --reload

# Set SELinux in permissive mode (effectively disabling it)
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config


### DOCKER
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo


# https://kubernetes.io/docs/setup/production-environment/container-runtimes/#cri-o
# https://github.com/cri-o/cri-o/blob/main/tutorials/kubernetes.md
# https://docs.openshift.com/container-platform/3.11/crio/crio_runtime.html
for cri-o
/etc/crio/crio.conf
[crio.runtime]
cgroup_manager = "systemd"
sudo systemctl enable --now crio


cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF


### KUBERNETES
# set repo
sudo cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/repodata/repomd.xml.key
exclude=kubelet kubeadm kubectl cri-tools kubernetes-cni
EOF


sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
# sudo yum remove -y kubelet kubeadm kubectl --disableexcludes=kubernetes
sudo systemctl enable --now kubelet




# something to do with docker networking
unset http_proxy https_proxy
https://www.vnoob.com/2022/12/kubectl-6443-connection-refused/


sudo kubeadm init --cgroup-driver="systemd" 
# sudo kubeadm reset --force

kubeadm join 192.168.1.124:6443 --token k3dqlh.wc3asv8kgip4ku27 \
	--discovery-token-ca-cert-hash sha256:7979d8fff3aef36fc31b47bfff2ca29a40ad74f76e9e677d3e1d825fe8a787a0 


kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
