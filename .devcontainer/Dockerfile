FROM debian:bookworm-slim

COPY src/requirements.txt /tmp
RUN apt update \
    && apt install -y git gcc libboost-all-dev python3 python3-pip pypy3 lldb nodejs npm \
    && mkdir ~/.pip && echo "[global]\nbreak-system-packages = true" > ~/.pip/pip.conf \
    && pip3 install --upgrade pip && pip3 install -r /tmp/requirements.txt \
    && npm install -g atcoder-cli \
    && git clone https://github.com/atcoder/ac-library /root/ac-library \
    && apt clean && rm -rf /var/lib/apt/lists/* /tmp/requirements.txt

COPY src/templates/ /root/.config/atcoder-cli-nodejs/
RUN acc config default-task-choice all && acc config default-template cpp

COPY src/.bashrc /root/.bashrc
