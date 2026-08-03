FROM itzg/minecraft-server:latest

ENV EULA=TRUE

# Tipo Purpur optimizado y versión 1.21.1
ENV TYPE=PURPUR
ENV VERSION=1.21.1
ENV MEMORY=384M

# Instalar playit-cli
USER root
RUN apt-get update && apt-get install -y curl gnupg && rm -rf /var/lib/apt/lists/*
RUN curl -SsL https://playit-cloud.github.io/ppa/key.gpg | gpg --dearmor | tee /etc/apt/trusted.gpg.d/playit.gpg >/dev/null \
    && echo "deb [signed-by=/etc/apt/trusted.gpg.d/playit.gpg] https://playit-cloud.github.io/ppa/data/ ./" | tee /etc/apt/sources.list.d/playit.list \
    && apt-get update \
    && apt-get install -y playit \
    && rm -rf /var/lib/apt/lists/*

# Script de inicio para ejecutar Playit y Minecraft
RUN echo '#!/bin/bash\n\
if [ -n "$PLAYIT_SECRET_KEY" ]; then\n\
    playit run --secret "$PLAYIT_SECRET_KEY" &\n\
else\n\
    playit run &\n\
fi\n\
exec /start\n\
' > /start-with-playit.sh && chmod +x /start-with-playit.sh

EXPOSE 25565

ENTRYPOINT ["/start-with-playi
t.sh"]
