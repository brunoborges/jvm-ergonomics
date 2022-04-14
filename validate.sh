#!/bin/bash
imagerepo=$1
imageversion=$2

containerimage=$1:$2

# Check if Microsoft Build of OpenJDK
if [[ $imagerepo == "mcr.microsoft.com/openjdk/jdk" ]]; then
  containerimage = $containerimage-ubuntu
fi

echo "Running image $containerimage with 1791mb of memory..."

docker run --memory=1791m $containerimage java -XX:+PrintFlagsFinal -XX:+UseContainerSupport -version > output

grep '.*SerialGC.*true.*' output

if [[ $? == 0 ]]; then
  echo "PASSED: SerialGC is selected"
else
  echo "FAILED: SerialGC is not selected"
fi  
