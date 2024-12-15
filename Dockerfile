FROM ubuntu:22.04
SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]
RUN \
  apt-get update; \
  apt-get install -y curl vim git make gcc; \
  apt-get clean

RUN adduser sam
WORKDIR /home/sam
USER sam
ENV PATH=/usr/local/go/bin:/usr/local/tinygo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin USER=sam HOME=/home/sam
RUN \
  mkdir -p git/github; \
  cd git; \
  git clone https://github.com/samrocketman/home.git; \
  cd home; \
  ./setup.sh; \
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD /bin/bash
