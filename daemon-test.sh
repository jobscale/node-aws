#!/usr/bin/env bash

{
  docker rm -f dind
  docker run --name dind --privileged -it ghcr.io/jobscale/node-aws:dind bash
  while true
  do
    echo "restart $(docker restart dind)"
    sleep 3.3
    echo exec
    docker exec -it dind docker ps -a
    echo -e "\nsleep"
    sleep 2.2
  done
}
