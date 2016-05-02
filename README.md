# Kubernetes Demo 
```
Prerequisites:
- Vagrant
- Ruby
```

## The architecture
This repo will be a single machine running Kubernetes as a lab environment. Puppet will build the Kubernetes components, then create a single pod running nginx. Once nginx is running Puppet will register 
the pod as a Kubernetes service.  


# Run the environment
```
git clone https://github.com/scotty-c/kubernetes-demo.git && cd kubernetes-demo
vagrant up
```

# Access the environment 

To see nginx

```
http://172.17.9.101
```

To check the cluster with kubectl
```
kubectl -s http://172.17.9.101:8080 get nodes

```
