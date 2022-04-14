#!/bin/bash
imagerepo=$1
imageversion=$2

containerimage=$1:$2

# Check if Microsoft Build of OpenJDK
if [[ $containerimage == *"microsoft"* ]]; then
  containerimage = $containerimage-ubuntu
fi

echo "Running image $containerimage"

docker run --memory=256m $containerimage java -XX:+PrintFlagsFinal -XX:+UseContainerSupport -version | grep 'SerialGC'
