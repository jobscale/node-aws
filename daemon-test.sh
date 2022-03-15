while true
do
  echo restart
  docker restart dind
  sleep 3.3
  docker exec -it dind docker ps -a
  echo sleep
  sleep 2.2
done

