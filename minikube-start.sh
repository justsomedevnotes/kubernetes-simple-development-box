#!/bin/bash		

# build a startup file
sudo minikube start --vm-driver=none --apiserver-ips=127.0.0.1
sudo chown -R vagrant $HOME/.kube
sudo chgrp -R vagrant $HOME/.kube
sudo chown -R vagrant $HOME/.minikube
sudo chgrp -R vagrant $HOME/.minikube

