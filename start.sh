#!/bin/bash

echo "eula=true" > eula.txt

java -Xms1G -Xmx2G -jar paper.jar nogui
