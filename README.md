#### run with container

```bash
git clone https://github.com/jobscale/node-aws.git
cd node-aws

docker build . -t local/node-aws \
 && docker run --rm --name node-aws -it local/node-aws
```
