FROM debian:bullseye

RUN apt update && apt install -y curl apache2-utils \
	apt-transport-https ca-certificates 

RUN curl -L https://github.com/portainer/portainer/releases/download/2.19.5/portainer-2.19.5-linux-amd64.tar.gz -o portainer.tar.gz && \
    tar -xzvf portainer.tar.gz && \
    rm portainer.tar.gz

COPY ./tools/prte_up.sh /tmp/prte_up.sh

CMD ["bash", "/tmp/prte_up.sh"]
