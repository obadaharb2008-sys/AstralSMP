FROM eclipse-temurin:17-jdk

WORKDIR /app

RUN apt-get update && \
    apt-get install -y curl unzip jq && \
    rm -rf /var/lib/apt/lists/*

# Get latest PaperMC version & latest build
RUN export VERSION=$(curl -s https://api.papermc.io/v2/projects/paper | jq -r '.versions[-1]') && \
    export BUILD=$(curl -s https://api.papermc.io/v2/projects/paper/versions/$VERSION | jq -r '.builds[-1]') && \
    curl -o paper.jar "https://api.papermc.io/v2/projects/paper/versions/$VERSION/builds/$BUILD/downloads/paper-$VERSION-$BUILD.jar"

RUN curl -L -o geyser.jar https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/server.jar
RUN curl -L -o floodgate.jar https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/server.jar

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 25565
EXPOSE 19132/udp

CMD ["/app/start.sh"]
