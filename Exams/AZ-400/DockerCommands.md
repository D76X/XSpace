## Docker Engine Management

Refs

- https://github.com/docker/cli/tree/master/docs/reference/commandline

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

---

## Swarm

- https://github.com/docker/swarmkit  
- https://github.com/docker/cli/tree/master/docs/reference/commandline

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

- https://docs.docker.com/engine/swarm/services/

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

| Command | Results |
| ------- | ------- |
| docker service update --publish-rm 8080 [service_name] | Remove a swarm published port for a service .|
| docker service update --publish-add mode=host,published=8090,target=8080 [service_name] [image_name] | Updates a published service to publish mode **host**. Each container of the service is going to be available on port 8090 of the corresponding node which is mapped to port 8080 of the container.|
| docker service update --publish-add mode=host,target=8080 [service_name] [image_name] | The same as above but the published port is going to be randomly assigned.|

### Swarm Service Updates

- https://app.pluralsight.com/course-player?clipId=120bbcbf-da81-43e1-a1bf-4455c3383c00
- https://docs.docker.com/engine/reference/commandline/service_update/
- https://github.com/docker/cli/blob/master/docs/reference/commandline/service_update.md

| Command | Results |
| ------- | ------- |
| docker service update --update-delay=1m5s --parallelism=2 [service_name] [image_name] | Update the service `service_name` with the specified `UpdateConfig` specification delay=1m5s & .parallelism=2 which are then permanently stored as part of the `UpdateConfig` section of the service definition.|
| docker service update --update-failure-action=continue/pause [service_name] [image_name] | Update the service `service_name` with the specified `UpdateConfig` specificationupdate-failure-action=`continue` or `pause` which is then permanently stored as part of the `UpdateConfig` section of the service definition.|
| docker service update [service_name] [service_name:version2] | Updates the servive to the image tagged with `version2`. This can be combined with any of the flags from the examples above.|
| docker service update --force [service_name] | The --force flags causes the service to be redeplyed to the swarm whether ir not any change has been made to its definition. All current tasks will reach to SHUTDOWN state and new teasks will replace them and the same goes for the corresponding containers. |

### Swarm Service Rollback

- https://app.pluralsight.com/course-player?clipId=1044ce44-275a-414e-9c11-5987faec8821
- https://medium.com/better-programming/rollout-and-rollback-in-docker-swarm-7f19e2fe2cd1

| Command | Results |
| ------- | ------- |
| docker service update --rollback [service_name]  | Rollback the service definition of `service_name` and this also updates the running service if the rollback has a desired state different from its current state. Rollabck only swaps the last two specs of the service it does not let you go back in time with the service definition that is when you rollback the previous spec of the service becames the latest and the latest is set to the previous spec so if you rollback again then these swap.|

### Swarm Service Scale

| Command | Results |
| ------- | ------- |
| docker service scale [service_name]=0| Remove a service by setting its replication value to 0. However, the definition of the service is NOT removed from the swarm. This means that a later scale up is possible.|
| docker service scale [service_name]=3| Updates the service definition to a REPLICA SET of 3.|
| docker service scale [service_name]=3| Updates the service definition to a REPLICA SET of 3.|

### Swarm Service Removal

| Command | Results |
| ------- | ------- |
| docker service rm| Remove a service (the definition of a service) from a swarm. This means that the Docker engine will no longer try to match its desired state on the swarm cluster.|

---

### Swarm Networks

| Command | Results |
| ------- | ------- |
| docker network inspect [ingress/network_name] --pretty | Show details about a network on the swarm cluster i.e. the ingress network.|

---

## Watch Commands

- https://superuser.com/questions/191063/what-is-the-windows-analog-of-the-linux-watch-command

| Command | Results |
| ------- | ------- |
| watch -d -n 0.5  docker service inspect [service_name] | Sets a console watch in detached mode (-d) with an update rate of 0.5s for the command `service inspect [service_name]`.|
| watch -d -n 0.5  docker service ls | Sets a console watch in detached mode (-d) with an update rate of 0.5s for the command `service ls`.|
| watch -d -n 0.5  docker service ps [service_name] | Sets a console watch in detached mode (-d) with an update rate of 0.5s for the command `service ps [service_name]`.|
| watch -d -n 0.5  \"docker service inspect [service_name] \| jq.[].UpdateStatus\" | As above but the with the command `docker service inspect [service_name] | jq.[].UpdateStatus`. The `jq.[].UpdateStatus` pulls out the `UpdateStatus` section from the JSON document that is output by the `docker service inspect [service_name]` command which is piped into it.|
| watch -d -n 0.5  \"docker service inspect [service_name] \| jq.[].Spec.UpdateStatus\" | As above but this time the `Spec.UpdateStatus` is pulled out.|