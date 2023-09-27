# Query etcd Demo

### Steps to deploy a kind cluster and query etcd

Step 1: Create cluster  
~~~
kind create cluster --config kind-config.yaml
~~~

Step 2: Get container ID for kind-control-plane
~~~
docker ps --filter "name=kind-control-plane" --format "{{.ID}}"
~~~

Step3: Copy crt and key files from container to use for etcd authentication 
~~~
docker cp <container_id>:/etc/kubernetes/pki/etcd/ca.crt .
docker cp <container_id>:/etc/kubernetes/pki/etcd/server.crt .
docker cp <container_id>:/etc/kubernetes/pki/etcd/server.key .
~~~

Step 4: Test etcd connection and get all keys  
~~~
ETCDCTL_API=3 etcdctl \
    --endpoints=https://127.0.0.1:2379 \
    --cacert=ca.crt \
    --cert=server.crt \
    --key=server.key \
    get / --prefix --keys-only
~~~

Step 5: List current deployments  
~~~
ETCDCTL_API=3 etcdctl \
    --endpoints=https://127.0.0.1:2379 \
    --cacert=ca.crt --cert=server.crt \
    --key=server.key \
    get /registry/deployments --prefix --keys-only
~~~

### etcd cheat sheet 
https://lzone.de/cheat-sheet/etcd