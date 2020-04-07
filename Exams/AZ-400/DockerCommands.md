# Docker

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
| docker service create --name [service_name] -p 9000:80 [nginx] | As above but port 9000 on the node is mapped to 80 on the container. |
| docker service create --name [service_name] -p 9000:80 [nginx] --constraint node.hostname==w4 | As above a **contraint** is added to the definition of the service so that only nodes that satisfy the constraint can be used to allocate the container. |

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

- https://app.pluralsight.com/course-player?clipId=f8ded8a9-abcf-4423-937d-24ba6be8b701

### Swarm Service Logs

-- https://app.pluralsight.com/course-player?clipId=f8ded8a9-abcf-4423-937d-24ba6be8b701

When an app runs in a container it may log to the output stream of the container, The following command then makes it possible to look at the output stream of any containers used by a service on the swarm.

| Command | Results |
| ------- | ------- |
| docker service logs [service_name] | Stream the logs for the service from any **manager** node of the swarm.|

---

### Swarm Networks

- https://app.pluralsight.com/course-player?clipId=74581a4d-8a46-47e3-b51b-382789101016   
- https://app.pluralsight.com/course-player?clipId=564cf8a5-1ce8-4432-bae4-883b129fb869

When you create a service on a swam that is partitioned over multiple containers (tasks) these are by default all connected to the default `ingress overlay network` which is created for you by the Docker Engine when the service is deployed by means of the `docker service create` command. However, this network is a `service network` used by the Docker Engine to run the service and it has the only purpose to allow requests from outside the swarm (client requests) to be routed to the nodes of the swarm where the service's cantaiers have been deployed. It **must** not be used in any other way. 

If you need to make sure the containers of a service can talk to each other i.e. when some containers are for the front end tier of the app and some other are for the frontend tier and you need the former to be able to talk to the latter then all these containers must be place on the same netweok. On a single node service deplyment a bridge netwok would suffice but with a swarm these newtwork must be an overlay network scoped to teh swarm as a bridge network cannot do that. 

Make sure that the value passed to the --subnet flag does not collide with any existing subnets which are already in use. 

| Command | Results |
| ------- | ------- |
| docker network ls | Lists all the networks that the current node is connected to.|
| docker network inspect [ingress/network_name] --pretty | Show details about a network on the swarm cluster i.e. the ingress network.|
| docker network create --driver overlay --subnet=10.0.9.0/24 frontend | Creates a swarm network named `frontend` and using the `overlay driver` so that it can be scoped to a swarm.|

---

### Swarm & Service Examples

#### Example 1

1. On a node where the Docker Engine is present create a swarm. This will automatically elected to **Master node with Leader Role**. When a swarm is created the Docker Engine automatically creates the `overlay` network `ingress` that is used only by the Docker Engine to route external request to services deployed to the swarm. 

```
docker swarm init
```

2. On the **Master node with Leader Role** (or any **Master Node** even if it is not the leader node of the swarm) use the following to request a join token that will be used to add nodes to the swarm as required.

- To obtain a join token for a node that must be a master node use :

```
docker swarm join-token manager
```

- To obtaina join token for a node that must be a worker node use :

```
docker swarm join-token worker
```

3. On any other node that you would like to add to the swarm use the following to join the node to the swarm as either a worker node or a master node. This connects the node to the `ingress overlay network` of the swarm.

```
docker swarm join --token [join-token] [IP:PORT]
```

4. From a master node on the swarm create a `overlay` network `scoped to the swarm`. This overlay network will be used to connect the containers of the tasks run by a service. Make sure this overlay network for the service is defined on a subnet that is not in used on the infrastructure in the example `--subnet=10.0.9.0/24`. In the example belo this network is named `frontend`.

```
docker network create --driver overlay --subnet=10.0.9.0/24 frontend
```

5. On any master node of the swarm create a `service definition` and if required make the **containers** of the taks for the service join the `service network`, which in this example has been named `backend`. This allows the containers to find each other through the `docker dns service`. In the following example a service definition is created on the swarm of the node on which the command is run. The service definition states that `myfrontendservice` is based on the image `myrepository/myimage-frontend:tag` and any container that is going to be created on any node of the swarm will bind its port 3000 to the port 5000 of the hosting node. 

The containers will also join the `backend` network that was previously defined on the swarm. Any container created and allocated by the scheduler to run this service will be able to communicate directly with others container of the same service which are also going to be on the same network. The Docker engine provides a **load balancer** on such a network to **round robin** the request amongst the containers for the service.

The `--env-add BACKEND-EP:mybackendservice:3000` fragment makes available an `environment variable` to any container of the `myfrontendservice`. Notice that its value is `mybackendservice:3000` which is to be intended as `HOST:PORT` where the `HOST` is set to the value `mybackendservice`. The frontend app then will use this env variable to set its base address for the backend it calls to. When any of the apps of the frontend service containers makes calles to `http://mybackendservice:3000` the `DNS` service of the `backend` overlay network resolves to the IP address of any of the containers for the backend service through a load balancer in the usual round robin fashion. This `backend` overlay network `DNS` is capable to `route host names that are service names`. 

```
docker service create -name myfrontendservice `
-p 5000:3000 `
--network backend `
--env-add BACKEND-EP:mybackendservice:3000
myrepository/myimage-frontend:tag
```

6. Now that the `front end service` has been declared and made available on port 5000 of any node of teh swarm that is host to a container from the image `myrepository/myimage:tag`, it is possible to repeat teh procedure to create a `backend service` that is connected to the same `backend` network. However, this time the service does not require the hosting nodes to have any of their external ports mapped to the containers mapped in them as these need not to be reached externally. Only the containers of the `front end service` need to be able to find the containers of the `backend service` and for this it's sufficent to share the same `frontend overlay netwok`.

```
docker service create -name mybackendservice `
--network frontend `
myrepository/myimage-backend:tag
```

7. Inspect the services available on the swarm from any of ots master nodes with the following command. 

```
docker service ls
```

---

### Stacks

Stacks are collections of related Docker Services which can be managed as a single deployment.

---

## Watch Commands

- https://superuser.com/questions/191063/what-is-the-windows-analog-of-the-linux-watch-command  
- https://github.com/moby/moby/issues/27147

| Command | Results |
| ------- | ------- |
| watch -d -n 0.5  docker service inspect [service_name] | Sets a console watch in detached mode (-d) with an update rate of 0.5s for the command `service inspect [service_name]`.|
| watch -d -n 0.5  docker service ls | Sets a console watch in detached mode (-d) with an update rate of 0.5s for the command `service ls`.|
| watch -d -n 0.5  docker service ps [service_name] | Sets a console watch in detached mode (-d) with an update rate of 0.5s for the command `service ps [service_name]`.|
| watch -d -n 0.5  \"docker service inspect [service_name] \| jq.[].UpdateStatus\" | As above but the with the command `docker service inspect [service_name] | jq.[].UpdateStatus`. The `jq.[].UpdateStatus` pulls out the `UpdateStatus` section from the JSON document that is output by the `docker service inspect [service_name]` command which is piped into it.|
| watch -d -n 0.5  \"docker service inspect [service_name] \| jq.[].Spec.UpdateStatus\" | As above but this time the `Spec.UpdateStatus` is pulled out.|

---

## Docker Compose

| Command | Results |
| ------- | ------- |