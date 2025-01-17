#!/bin/bash

[ "$architecture" == "amd64" ] && image=portainer/portainer-ce:latest
[ "$architecture" == "arm/v7" ]  && image=portainer/portainer-ce:latest
[ "$architecture" == "arm64" ] && image=portainer/portainer-ce:latest
[ "$architecture" == "ppc64le" ] && image=portainer/portainer-ce:latest
[ "$architecture" == "s390x" ] && image=portainer/portainer-ce:latest

[ -z $image ] && ynh_die "Sorry, your $architecture architecture is not supported ..."

options="-e VIRTUAL_HOST=$domain -p $port:9000 -v $data_path/data:/data -v /var/run/docker.sock:/var/run/docker.sock"
containeroptions=""

iptables -t filter -N DOCKER 

docker run -d --name=$app --restart always $options $image $containeroptions 1>&2
CR=$?

echo $CR
