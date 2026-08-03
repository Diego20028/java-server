FROM itzg/minecraft-server:latest

# Aceptar EULA
ENV EULA=TRUE

# Tipo de servidor optimizado para poca RAM
ENV TYPE=PAPER
ENV VERSION=1.20.4

# Ajustar uso de memoria
ENV MEMORY=512M

EXPOSE 25
565
