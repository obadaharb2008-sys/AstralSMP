FROM eclipse-temurin:17-jdk

WORKDIR /app

RUN apt-get update && \
    apt-get install -y curl unzip && \
    rm -rf /var/lib/apt/lists/*

# Install Paper (latest)
RUN curl https://api.papermc.io/v2/projects/paper | \
    grep -o '"versions":.*' | \
    sed 's/"versions":\[//;s/\]//' | \
    sed 's/"//g' | \
    tr -d ' ' | \
    tr ',' '\n' | \
    tail -1 > latest_version

RUN export VERSION=$(cat latest_version) && \
    curl -o paper.jar \
    "https://api.papermc.io/v2/projects/paper/versions/${VERSION}/builds/1/downloads/paper-${VERSION}-1.jar"

# Geyser + Floodgate
RUN curl -L -o geyser.jar https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/server.jar
RUN curl -L -o floodgate.jar https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/server.jar

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 25565
EXPOSE 19132/udp

CMD ["/app/start.sh"]
