#!/bin/bash
export NAME="$(whoami)-$RANDOM"
eksctl create cluster -f ./eksctl-cilium.yaml


# Instalación de Cilium CLI en el host

#CILIUM_CLI_VERSION=$(curl -s
#https://raw.githubusercontent.com/cilium/cilium-cli/main/stable-v0.14.txt)
#CLI_ARCH=amd64
#if [ "$(uname -m)" = "aarch64" ]; then CLI_ARCH=arm64; fi
#curl -L --fail --remote-name-all
#https://github.com/cilium/cilium-cli/releases/download/$
#{CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
#sha256sum --check cilium-linux-${CLI_ARCH}.tar.gz.sha256sum
#sudo tar xzvfC cilium-linux-${CLI_ARCH}.tar.gz /usr/local/bin
#rm cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}

# Instalación del Cilium en el Cluster EKS (requiere conexión kubectl y helm)
# Nota: Recuerda que es posible que te pete con el fichero config de kubectl porque el nombre del cluster
# por lo que sea (regex) no le mola, cambialo
# cilium install
# cilium status --wait

# Instalación de Hubble CLI (observabilidad de red)
#export HUBBLE_VERSION=$(curl -s
#https://raw.githubusercontent.com/cilium/hubble/master/stable.txt)
#HUBBLE_ARCH=amd64
#if [ "$(uname -m)" = "aarch64" ]; then HUBBLE_ARCH=arm64; fi
#curl -L --fail --remote-name-all
#https://github.com/cilium/hubble/releases/download/$HUBBLE_VERSION/
#hubble-linux-${HUBBLE_ARCH}.tar.gz{,.sha256sum}
#sha256sum --check hubble-linux-${HUBBLE_ARCH}.tar.gz.sha256sum
#sudo tar xzvfC hubble-linux-${HUBBLE_ARCH}.tar.gz /usr/local/bin
#rm hubble-linux-${HUBBLE_ARCH}.tar.gz{,.sha256sum}

# Instalación del Web UI de Cilium Hubble
# cilium hubble enable --ui

# Port Forward del servicio de Hubble UI
# cilium hubble ui
# Abrir la url localhost que te ofrezca la salida