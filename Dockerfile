FROM node:lts-bookworm-slim
SHELL ["bash", "-c"]
WORKDIR /home/node
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y locales curl git vim unzip iproute2 dnsutils netcat-openbsd \
    less tree jq python3-pip sudo
RUN rm -fr /var/lib/apt/lists/*
RUN usermod -aG sudo node && echo '%sudo ALL=(ALL:ALL) NOPASSWD:ALL' > /etc/sudoers.d/40-users
RUN sed -i -e 's/# ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/' /etc/locale.gen && locale-gen && update-locale LANG=ja_JP.UTF-8 \
 && echo -e "export LANG=ja_JP.UTF-8\nexport TZ=Asia/Tokyo\numask u=rwx,g=rx,o=rx" | tee -a /etc/bash.bashrc
RUN curl -sL "https://awscli.amazonaws.com/awscli-exe-linux-$(arch).zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip && aws/install && rm -fr aws awscliv2.zip
RUN chown -R node. /usr/local/lib/node_modules && chown -R :node /usr/local/bin && chmod -R g+w /usr/local/bin

USER node
RUN npm i --location=global npm && npm version | xargs
RUN echo "PATH=\"\$PATH:~/.local/bin\"" >> /home/node/.bashrc
RUN echo "which aws_completer && complete -C aws_completer aws" >> /home/node/.bashrc
COPY . .
