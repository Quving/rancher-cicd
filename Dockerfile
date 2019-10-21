FROM debian:buster

MAINTAINER vinh-ngu@hotmail.com

ENV RANCHER_VERSION v2.3.0-rc6

# Install deps
RUN apt update; apt install -y wget

# Install rancher-cli
WORKDIR /app
RUN wget -O rancher-cli.tar.gz https://github.com/rancher/cli/releases/download/${RANCHER_VERSION}/rancher-linux-amd64-${RANCHER_VERSION}.tar.gz
RUN mkdir rancher-cli
RUN tar xvf rancher-cli.tar.gz -C rancher-cli --strip-components 2
RUN ln -s rancher-cli/rancher /usr/local/bin/rancher

COPY . .
RUN chmod +x entrypoint.sh

CMD ["./entrypoint.sh"]
