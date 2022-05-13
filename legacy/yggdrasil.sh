#!/bin/bash
curl -so- "https://circleci.com/api/v1.1/project/github/yggdrasil-network/yggdrasil-go/latest/artifacts?branch=master&filter=successful" | \
egrep -o "https.*yggdrasil\-.*$(dpkg --print-architecture).deb" | \
while read line; do curl -O $line && dpkg -i $(basename $line); done
