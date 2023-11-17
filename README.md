# run with container

debian bookworm based.

## docker build and run

```bash
git clone git@github.com:jobscale/node-aws.git
cd node-aws

docker build . -t local/node-aws \
 && docker run --name node-aws -it local/node-aws bash

docker start node-aws && docker exec -it node-aws bash
```

## Docker in Docker

### run dind

```
docker run --privileged --restart always --name dind -it ghcr.io/jobscale/node-aws:dind bash
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
pip install aws-sam-cli --user
sam --version

# upgrade
pip install --upgrade aws-sam-cli --user
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
pip install git-remote-codecommit --user
```

### jp - JMESPath

```
npm i -g @jobscale/jp
jp --version
```
