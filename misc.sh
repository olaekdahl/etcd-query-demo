# etcd cheat sheet 
https://lzone.de/cheat-sheet/etcd

kind create cluster --config kind-config.yaml

# get docker id
docker ps 

# get container id
"$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "kind-control-plane"):2379"

docker cp 65e5e69baa5b:/etc/kubernetes/pki/etcd/ca.crt .
docker cp 65e5e69baa5b:/etc/kubernetes/pki/etcd/server.crt .
docker cp 65e5e69baa5b:/etc/kubernetes/pki/etcd/server.key .

ETCDCTL_API=3 etcdctl \
    --endpoints=https://127.0.0.1:2379 \
    --cacert=ca.crt \
    --cert=server.crt \
    --key=server.key \
    get / --prefix --keys-only

    ETCDCTL_API=3 etcdctl \
        --endpoints=https://127.0.0.1:2379 \
        --cacert=ca.crt --cert=server.crt \
        --key=server.key \
        get /registry/deployments --prefix --keys-only
