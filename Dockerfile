FROM node:bullseye
SHELL ["bash", "-c"]
WORKDIR /home/node
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y locales git zip unzip vim curl iproute2 dnsutils netcat less python3-pip sudo
RUN rm -fr /var/lib/apt/lists/*
RUN usermod -aG sudo node && echo '%sudo ALL=(ALL:ALL) NOPASSWD:ALL' > /etc/sudoers.d/40-users
RUN sed -i -e 's/# ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/' /etc/locale.gen && locale-gen && update-locale LANG=ja_JP.UTF-8 \
 && echo -e "export LANG=ja_JP.UTF-8\nexport TZ=Asia/Tokyo\numask u=rwx,g=rx,o=rx" | tee -a /etc/bash.bashrc
RUN curl -sL "https://awscli.amazonaws.com/awscli-exe-linux-$(arch).zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip && ./aws/install && rm -fr aws awscliv2.zip
RUN pip3 install awslogs
RUN curl -sL "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_$( \
  ([[ $(arch) == aarch64 ]] && echo arm64) || ([[ $(arch) == x86_64 ]] && echo amd64) \
 ).tar.gz" | tar xz -C /tmp \
 && mv /tmp/eksctl /usr/local/bin
RUN npm i -g npm
RUN npm i -g aws-sdk serverless
RUN aws --version && awslogs --version && eksctl version
RUN chown -R node. /usr/local/lib/node_modules
USER 1000
CMD ["bash", "-c", "while true; do sleep 600; done"]
