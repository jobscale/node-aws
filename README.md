# run with container

debian13 trixie based.
debian12 bookworm based.

## docker build and run

```bash
git clone https://github.com/jobscale/node-aws.git
cd node-aws

docker build . -t local/node-aws \
 && docker run --name node-aws -it local/node-aws bash

docker start node-aws && docker exec -it node-aws bash
```

## Docker in Docker

### run dind

```
{
  docker run --privileged --name dind --restart always \
  --ulimit nofile=128:256 --ulimit nproc=32:64 -d ghcr.io/jobscale/node-aws:dind
  docker logs --since 5m -f dind
}
```

### test dind

```
./daemon-test
```

## More installation

### npm

```
npm i -g npm@latest
```

### serverless

```
npm i -g serverless
serverless --version
```

### sam

```
pipx install aws-sam-cli
sam --version
```

### amplify

```
npm i -g @aws-amplify/cli
amplify --version
```

### vue v3

```
npm i -g @vue/cli
vue --version
```

### CodeCommit GRC

```
pipx install git-remote-codecommit
which git-remote-codecommit
```

### jp - JMESPath

```
npm i -g @jobscale/jp
jp --version
```
