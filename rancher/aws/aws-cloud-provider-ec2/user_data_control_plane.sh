#!/bin/sh

PUBLIC_IP=$(curl ifconfig.io)

export INSTALL_RKE2_VERSION="v1.26.6+rke2r1"

curl -sfL https://get.rke2.io | sh -

provider_id="$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)/$(curl -s http://169.254.169.254/latest/meta-data/instance-id)"

mkdir -p /etc/rancher/rke2
cat > /etc/rancher/rke2/config.yaml << EOF
node-name: $(hostname -f)
write-kubeconfig-mode: "0640"
tls-san:
  - "${PUBLIC_IP}"
  - "${PUBLIC_IP}.nip.io"
kubelet-arg:
  - cloud-provider=external
  - provider-id=aws:///$provider_id
kube-apiserver-arg: cloud-provider=external
kube-controller-manager-arg: cloud-provider=external
disable-cloud-controller: true
EOF


mkdir -p /var/lib/rancher/rke2/server/manifests

cat > /var/lib/rancher/rke2/server/manifests/00-aws-ccm.yaml << EOF
apiVersion: helm.cattle.io/v1
kind: HelmChart
metadata:
  name: aws-cloud-controller-manager
  namespace: kube-system
spec:
  chart: aws-cloud-controller-manager
  repo: https://kubernetes.github.io/cloud-provider-aws
  version: v1.26.1
  targetNamespace: kube-system
  bootstrap: true
  valuesContent: |-
    nodeSelector:
      node-role.kubernetes.io/master: "true"
    hostNetworking: true
    args:
      - --configure-cloud-routes=false
      - --v=2
      - --cloud-provider=aws
EOF


systemctl enable rke2-server
systemctl restart rke2-server