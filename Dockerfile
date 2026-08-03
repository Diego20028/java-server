FROM itzg/minecraft-server:latest

# Aceptar EULA
ENV EULA=TRUE

# Tipo de servidor y versión (PaperMC optimizado para pocos recursos)
ENV TYPE=PAPER
ENV VERSION=1.20.4

# Ajustar uso de memoria para el plan gratuito de Render (512M)
ENV MEMORY=512M

# Instalar playit-cli
USER root
RUN apt-get update && apt-get install -y curl gnupg && rm -rf /var/lib/apt/lists/*
RUN curl -SsL https://playit-cloud.github.io/ppa/key.gpg | gpg --dearmor | tee /etc/apt/trusted.gpg.d/playit.gpg >/dev/null \
    && echo "deb [signed-by=/etc/apt/trusted.gpg.d/playit.gpg] https://playit-cloud.github.io/ppa/data/ ./" | tee /etc/apt/sources.list.d/playit.list \
    && apt-get update \
    && apt-get install -y playit \
    && rm -rf /var/lib/apt/lists/*

# Crear script para ejecutar Playit y Minecraft al mismo tiempo
RUN echo '#!/bin/bash\n\
if [ -n "$PLAYIT_SECRET_KEY" ]; then\n\
    playit run --secret "$PLAYIT_SECRET_KEY" &\n\
else\n\
    playit run &\n\
fi\n\
exec /start\n\
' > /start-with-playit.sh && chmod +x /start-with-playit.sh

EXPOSE 25565

ENTRYPOINT ["/start-with-play
it.sh"]
