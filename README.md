# Introduction
This post covers a method to stand up a simple isolated  Kubernetes environment using Minikube with the --vm-driver=none option and Vagrant.  The --vm-driver option is used to specify which infrastructure provider minikube will use.  The default is virtualbox.  Virtualbox is generally fine except in cases where your environment (guest environment in this case) does not support nested virtualization.  This is where vm-driver=none provides a solution.  
Here we are taking advantage of the --vm-driver=none to invoke the guest's VM local docker engine instead of one on a single node virtual box instance which is the default behavior, and using Vagrant to isolate a guest Kubernetes environment from the host.  Basically putting minikube on the guest VM rather than having minikube start a guest VM.  

## Prerequisits
An environment with Docker, Minikube, and Kubectl.  There is a Vagrantfile in the http://github.com/justsomedevnotes/Kubernetes-simple-development-box repository that contains the necessary binaries.


## Step 1: Create the Cluster
To start minikube with no vm-driver, simply use the command below. After you run the command you need to update the .kube and .minikube files as shown on the output.  I have provided a minikube-start.sh script in the http://github.com/justsomedevnotes/kubernetes-simple-development-box repository that starts minikube and updates the files required.  There is also a minikube-destroy.sh as well.  
```console
sudo minikube start --vm-driver=none
```
Or use
```console
cd /vagrant
./minikube-start.sh
```

## Step 2: Test the Environment

This is pretty basic for illustration purposes to show the box works.  We are just going to create a nginx pod, grab its IP, and connect to it.  Use the pod.yaml below and paste it in a file.  The pod.yaml is also found at the http://github.com/justsomedevnotes/kubernetes-simple-development-box repository.

```console
apiVersion: v1
kind: Pod
metadata:
  name: justapod
spec:
  containers:
  - image: nginx
    name: nnginx
    
    ```
    
```console
kubectl create -f pod.yaml
```

Verify the pod has a status of 'running' using the following command. 
```console
kubectl get pods
```

Assuming the nginx pod is running, capture the pod IP.  
```console
export PODIP=$(kubectl get pod justapod -o json | jq -r .status.podIP)
```

Finally, access the nginx container.  
```console
curl ${PODIP}
```
