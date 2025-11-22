#!/bin/bash
echo "eula=true" > eula.txt
java -Xms256M -Xmx512M -jar paper.jar nogui

