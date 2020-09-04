FROM ubuntu:20.04
RUN apt update -y && apt upgrade -y
#RUN apt install -y git curl wget
# Use GNU time, not the Bash builtin
RUN apt install -y time
RUN apt install -y wget
RUN apt install -y locate
RUN apt install -y mlocate
RUN wget https://github.com/sharkdp/fd/releases/download/v8.1.1/fd-musl_8.1.1_amd64.deb
RUN dpkg -i fd-musl_8.1.1_amd64.deb
RUN apt install -y silversearcher-ag
RUN apt install -y ack-grep
RUN wget https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep-12.1.1-x86_64-unknown-linux-musl.tar.gz
RUN tar zxvf ripgrep-12.1.1-x86_64-unknown-linux-musl.tar.gz
RUN cp ripgrep-12.1.1-x86_64-unknown-linux-musl/rg /usr/bin
RUN mkdir -p /work
# Run the initial updatedb
RUN updatedb
COPY scripts.tar /
RUN tar xvf scripts.tar
WORKDIR /scripts
ENTRYPOINT ["./bench.sh"]


