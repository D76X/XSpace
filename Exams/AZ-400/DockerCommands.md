### Docker Engine Management

Refs

- https://github.com/docker/swarmkit

| Command | Results |
| ------- | ------- |
| docker info | Get all the Doker info on the current node. |
| docker info \| grep [Name]| Get only the [Name] info from the Doker info on the current node (**grep** works on linux nodes). |
| docker info \| sls [Name]| Get only the [Name] info from the Doker info on the current node (**sls** works on Windows nodes). |
| docker info \| sls [Swarm]| Get only the [Swarm] info from the Doker info on the current node (**sls** works on Windows nodes). |

| Command | Results |
| ------- | ------- |
| docker inspect [any_docker_assets_id/name] | Get all the Doker info relevant to the docker asset with the given id/name i.e. service, task, network. |

| Command | Results |
| ------- | ------- |


### Swarm

| Command | Results |
| ------- | ------- |
| docker swarm init | Initializes a swarm on the current node which becomes automatically the **Leader (Manager)** node of the swarm. |
| docker swarm init --advertise-addr [IP]| As above but oyu specify the IP address of the network interface of the node that is to be joined toi the swarm network. This is  necessary on some VMs (nodes) which have multiple network interfaces.|
| export DOCKER_HOST=[192.168.99.213] | Any any node of a swarm resets the Docker CLI on node with the give IP (192.168.99.213 in this example). |
| docker info \| sls [Swarm]| Get only the [Swarm] info from the Doker info on the current node (**sls** works on Windows nodes). |
| docker swarm join-token [worker\|manager] | Requests a worker or manager join token to add a node to a swarm cluster. |
| docker swarm join --token [join-token] [IP:PORT] | Join the current node to a swarm cluster. |
| docker swarm leave | Remove the **current** node from the swarm. |
| docker node rm [node_id/node_namename] | Remove the node that is in DOWN state, use **--force** to forcibly remove a node which is NOT in DOWN state. |

### Swarm Services

- Services a declarative construct to specify a desired swarm cluster state for a specific container i.e. replicas. etc..
- Services are implemented by Tasks.
- Tasks are a declarative construct that specify the sate of a node in relation to a service on the cluster of which the node is part of.
- To each Task a node is bound. but the state of the node and that of the task may not be the same at all times.  

| Command | Results |
| ------- | ------- |
| docker service ls | Lists all the services on the swarm. |
| docker service ps [service_name] | Shows all the tasks of the [service_name] service on the swarm. |
| docker service inspect [service_name] --pretty | Show details about a service. |
| docker service inspect [task_id] --pretty | Show details about the service's task with the given id. |
| docker service create --name [service_name] -p target=80 [nginx] | Create a service on a swarm from the image nginx published on a **random** swarm port and mapped to port 80 on the container. |
| docker service docker service create --name [service_name] -p 9000:80 [nginx] | As above but port 9000 on the node is mapped to 80 on the container. |
| docker service docker service create --name [service_name] -p 9000:80 [nginx] --constraint node.hostname==w4 | As above a **contraint** is added to the definition of the service so that only nodes that satisfy the constraint can be used to allocate the container. |
| docker service update --publish-rm 8080 [service_name] | Remove a swarm published port for a service .|
| docker service update --publish-add mode=host,published=8090,target=8080 [service_name] [image_name] | Updates a published service to publish mode **host**. Each container of the service is going to be available on port 8090 of the corresponding node which is mapped to port 8080 of the container.|
| docker service update --publish-add mode=host,target=8080 [service_name] [image_name] | The same as above but the published port is going to be randomly assigned.|
| docker service rm| Remove a service (the definition of a service) from a swarm. This means that the Docker engine will no longer try to match its desired state on the swarm cluster.|
| docker service scale [service_name]=0| Remove a service by setting its replication value to 0. However, the definition of the service is NOT removed from the swarm. This means that a later scale up is possible.|
| docker service scale [service_name]=3| Updates the service definition to a REPLICA SET of 3.|


### Swarm Networks

| Command | Results |
| ------- | ------- |
| docker network inspect [ingress/network_name] --pretty | Show details about a network on the swarm cluster i.e. the ingress network. |

