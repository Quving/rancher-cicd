FROM alpine:latest

MAINTAINER vinh-ngu@hotmail.com

ENV RANCHER_VERSION v2.3.0-rc6
ENV TERM konsole

# Install deps
RUN apk add wget curl bash ncurses

# Install rancher-cli
RUN wget -O rancher-cli.tar.gz https://github.com/rancher/cli/releases/download/${RANCHER_VERSION}/rancher-linux-amd64-${RANCHER_VERSION}.tar.gz
RUN mkdir rancher-cli
RUN tar xvf rancher-cli.tar.gz -C rancher-cli --strip-components 2
RUN rm -rf rancher-cli.tar.gz
RUN ln -s /rancher-cli/rancher /usr/bin/rancher

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
RUN chmod +x kubectl
RUN ln -s /kubectl /usr/bin/kubectl

COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

WORKDIR /app
CMD ["/bin/entrypoint.sh"]
