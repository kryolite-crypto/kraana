FROM ubuntu:22.04

ENV PROMPT_COMMAND="history -a"

RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  curl unzip

RUN [ "$(uname -m)" = "aarch64" ] && arch=arm64 || arch=x64 \
  && mkdir /ghjk && cd /ghjk \
  && curl -fLOJ "https://github.com/kryolite-crypto/kryolite/releases/download/2.2.1/kryolite-kryolite-linux-${arch}.zip" \
  && unzip "kryolite-kryolite-linux-${arch}.zip" \
  && mv kryolite /usr/local/bin \
  && rm -rf /ghjk

RUN apt-get update && apt-get install -y --no-install-recommends \
  libicu-dev

RUN [ "$(uname -m)" = "aarch64" ] && arch=arm64 || arch=amd64 \
  && cd /usr/local \
  && curl -fLOJ "https://go.dev/dl/go1.21.1.linux-${arch}.tar.gz" \
  && tar -xvof "go1.21.1.linux-${arch}.tar.gz" \
  && rm -rf "go1.21.1.linux-${arch}.tar.gz"

RUN [ "$(uname -m)" = "aarch64" ] && arch=arm64 || arch=amd64 \
  && mkdir /ghjk && cd /ghjk \
  && curl -fLOJ "https://github.com/cespare/reflex/releases/download/v0.3.1/reflex_linux_${arch}.tar.gz" \
  && tar -xvof "reflex_linux_${arch}.tar.gz" \
  && mv "reflex_linux_${arch}/reflex" /usr/local/bin \
  && rm -rf /ghjk

ENV PATH=$PATH:/usr/local/go/bin

WORKDIR /app
COPY . .

ENTRYPOINT [ "/app/entrypoint.sh" ]
