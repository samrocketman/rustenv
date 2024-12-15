FROM ubuntu:22.04
SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]
RUN \
  apt-get update; \
  apt-get install -y curl vim git make gcc gcc-aarch64-linux-gnu; \
  apt-get clean; \
  curl -sSfLo /usr/local/bin/download-utilities.sh https://raw.githubusercontent.com/samrocketman/yml-install-files/refs/heads/main/download-utilities.sh; \
  chmod 755 /usr/local/bin/download-utilities.sh
COPY rust.yml /usr/local/share/
RUN download-utilities.sh /usr/local/share/rust.yml
RUN adduser sam
WORKDIR /home/sam
USER sam
ENV PATH=/usr/local/go/bin:/usr/local/tinygo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin USER=sam HOME=/home/sam
RUN \
  mkdir -p git/github; \
  cd git; \
  git clone https://github.com/samrocketman/home.git; \
  cd home; \
  ./setup.sh
RUN \
  echo 'export PATH=~/.cargo/bin:"$PATH"' >> ~/.bashrc; \
  curl -sSfI https://github.com/rust-lang/rust/releases/latest | \
  awk '$1 ~ /[Ll]ocation:/ { gsub(".*/[^0-9.]*", "", $0); print;exit}' | \
  tr -d '\r' | \
  xargs -n1 rustup-init -y --no-modify-path --default-toolchain
ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD /bin/bash
