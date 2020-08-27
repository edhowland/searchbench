FROM ubuntu:20.04
RUN apt update -y && apt upgrade -y
#RUN apt install -y git curl wget
RUN apt install -y wget
RUN apt install -y locate
RUN apt install -y mlocate
RUN apt install -y fd-find
RUN apt install -y silversearcher-ag
RUN apt install -y ack-grep
RUN wget https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep-12.1.1-x86_64-unknown-linux-musl.tar.gz
RUN tar zxvf ripgrep-12.1.1-x86_64-unknown-linux-musl.tar.gz
RUN cp ripgrep-12.1.1-x86_64-unknown-linux-musl/rg /usr/bin
# Run the initial updatedb
RUN updatedb
COPY scripts.tar /
RUN tar xvf scripts.tar
WORKDIR /scripts
ENTRYPOINT ["./bench.sh"]


