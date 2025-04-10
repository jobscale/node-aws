FROM node:lts-bookworm-slim
SHELL ["bash", "-c"]
WORKDIR /home/node
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends locales curl git vim unzip \
  iproute2 dnsutils ncat netcat-openbsd \
  less tree jq python3-pip sudo \
 && apt-get clean && rm -fr /var/lib/apt/lists/*
RUN usermod -aG sudo node && echo '%sudo ALL=(ALL:ALL) NOPASSWD:ALL' > /etc/sudoers.d/40-users
RUN sed -i -e 's/# ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/' /etc/locale.gen && locale-gen && update-locale LANG=ja_JP.UTF-8 \
 && echo -e "export LANG=ja_JP.UTF-8\nexport TZ=Asia/Tokyo\numask u=rwx,g=rx,o=rx" | tee -a /etc/bash.bashrc
RUN curl -sL "https://awscli.amazonaws.com/awscli-exe-linux-$(arch).zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip && aws/install && rm -fr aws awscliv2.zip
RUN usermod -aG staff node \
 && chown -R node:staff /usr/local/lib/node_modules \
 && chown -R :staff /usr/local/bin && chmod -R g+w /usr/local/bin \
 && chown -R :staff /usr/local/share && chmod -R g+w /usr/local/share

USER node
RUN npm version | xargs
RUN echo "PATH=\"\$PATH:~/.local/bin\"" >> /home/node/.bashrc
RUN echo "which aws_completer && complete -C aws_completer aws" >> /home/node/.bashrc
COPY --chown=node:node README.md .
