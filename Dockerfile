FROM itzg/minecraft-server:latest

ENV EULA=TRUE

# Purpur 1.21.1 con 384M de RAM
ENV TYPE=PURPUR
ENV VERSION=1.21.1
ENV MEMORY=384M

# Instalar playit
USER root
RUN apt-get update && apt-get install -y curl gnupg && rm -rf /var/lib/apt/lists/*
RUN curl -SsL https://playit-cloud.github.io/ppa/key.gpg | gpg --dearmor | tee /etc/apt/trusted.gpg.d/playit.gpg >/dev/null \
    && echo "deb [signed-by=/etc/apt/trusted.gpg.d/playit.gpg] https://playit-cloud.github.io/ppa/data/ ./" | tee /etc/apt/sources.list.d/playit.list \
    && apt-get update \
    && apt-get install -y playit \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 25565

# Comando simplificado en una sola linea
CMD playit run & /start
