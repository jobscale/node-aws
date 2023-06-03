FROM ghcr.io/jobscale/node-aws:main
USER root
RUN curl -sL jsx.jp/s/docker | bash && RUN usermod -aG docker node
COPY dind/docker-entrypoint.sh /usr/local/bin/
VOLUME /var/lib/docker
RUN echo -e "su - node\nexit" >> /root/.bashrc
