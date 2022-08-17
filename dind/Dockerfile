FROM ghcr.io/jobscale/node-aws:main
USER 0
RUN curl -Ls git.io/susi | bash && usermod -aG docker node
COPY docker-entrypoint.sh /usr/local/bin/
VOLUME /var/lib/docker
RUN echo -e "su - node\nexit" >> /root/.bashrc
