sudo sysctl fs.inotify.max_user_watches=524288
sudo sysctl fs.inotify.max_user_instances=512

sudo apt install net-tools -y
# sudo apt install make -y

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

curl -s https://raw.githubusercontent.com/karmada-io/karmada/master/hack/install-cli.sh | sudo INSTALL_CLI_VERSION=1.10.2 bash

helm repo add cilium https://helm.cilium.io/

# curl -LO https://dl.k8s.io/release/v1.27.3/bin/linux/amd64/kubectl
# mv /root/package/kubectl /usr/local/bin/kubectl
# chmod 777 /usr/local/bin/kubectl

# curl -L -o vcluster "https://github.com/loft-sh/vcluster/releases/latest/download/vcluster-linux-amd64" && sudo install -c -m 0755 vcluster /usr/local/bin && rm -f vcluster

for i in {1..3}
do
echo "  apiServerAddress: \"$(ifconfig eno1 |grep "inet " | cut -f 10 -d " ")"\" >> /root/ddos/env/config/kind-example-config-$i.yaml
done

kind create cluster --config /root/ddos/env/config/kind-example-config-1.yaml --name cluster0
sleep 10
cp /root/.kube/config /root/.kube/cluser0

kind create cluster --config /root/ddos/env/config/kind-example-config-2.yaml --name cluster1
sleep 10
cp /root/.kube/config /root/.kube/cluser1

kind create cluster --config /root/ddos/env/config/kind-example-config-3.yaml --name cluster2
cp /root/.kube/config /root/.kube/cluser2

sleep 30

for j in `seq 0 2`
		do
			kubectl config use-context kind-cluster$j
			helm repo update
			helm install cilium cilium/cilium --version 1.15.6 --namespace kube-system --set cluster.name=cluster$j --set cluster.id=$j
		done
echo "----------------$i OK----------------"