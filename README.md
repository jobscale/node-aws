#### run with container

```bash
git clone https://github.com/jobscale/node-aws.git
cd node-aws

docker build . -t local/node-aws
docker run --rm -it local/node-aws

docker build . -f Dockerfile-slim -t local/node-aws:slim
docker run --rm -it local/node-aws:slim
```
