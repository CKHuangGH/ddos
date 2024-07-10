kubectl config use-context kind-cluster0
karmadactl init
sleep 10
karmadactl join kind-cluster1 --cluster-kubeconfig=$HOME/.kube/config

kubectl --kubeconfig /etc/karmada/karmada-apiserver.config get clusters