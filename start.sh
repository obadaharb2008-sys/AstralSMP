#!/bin/bash

# Accept EULA
echo "eula=true" > eula.txt

# Start Paper with Geyser + Floodgate
java -Xms1G -Xmx2G -jar paper.jar nogui
