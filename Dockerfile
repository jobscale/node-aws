FROM node
SHELL ["bash", "-c"]
WORKDIR /home/node
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y locales vim curl netcat less
RUN curl -sL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip && ./aws/install && rm -fr aws awscliv2.zip
RUN curl -sL "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp \
 && mv /tmp/eksctl /usr/local/bin
RUN sed -i -e 's/# ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/' /etc/locale.gen && locale-gen && update-locale LANG=ja_JP.UTF-8 \
 && echo -e "export LANG=ja_JP.UTF-8\nexport TZ=Asia/Tokyo\numask u=rwx,g=rx,o=rx" | tee -a /root/.bashrc
RUN npm i -g serverless
ENTRYPOINT /bin/bash
USER 1000
