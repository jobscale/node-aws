# run with container

## docker build and run

```bash
git clone https://github.com/jobscale/node-aws.git
cd node-aws

docker build . -t local/node-aws \
 && docker run --name node-aws -it local/node-aws bash

docker start node-aws && docker exec -it node-aws bash
```

## More installation

### serverless

```
npm i serverless
serverless --version
```

### sam

```
pip install aws-sam-cli
sam --version
```

### amplify

```
npm i -g @aws-amplify/cli
amplify version
```
