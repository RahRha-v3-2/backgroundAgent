FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

RUN apt-get update && apt-get install -y \
    curl \
    git \
    jq \
    gh \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g @google/gemini-cli

RUN gh auth login --with-token < /dev/null || true

WORKDIR /app

COPY . .

RUN chmod +x scripts/setup.sh 2>/dev/null || true

LABEL org.opencontainers.image.source="https://github.com/RahRha-v3-2/backgroundAgent"
LABEL org.opencontainers.image.description="Self-driving AI agent system powered by Gemini CLI"

CMD ["/bin/bash"]
