#!/bin/bash
imagerepo=$1
imagetag=$2

containerimage=$1:$2

# Check if Microsoft Build of OpenJDK
if [[ "${imagetag}" -eq "mcr.microsoft.com/openjdk/jdk" ]]; then
  containerimage=$containerimage-ubuntu
fi

echo "Pull container image ${containerimage}..."
docker pull $containerimage

echo "Running image $containerimage ..."

# Test MaxRAMPercentage
echo "-- Test for RAMPercentage..."
docker run --memory=128m $containerimage java -XX:+PrintFlagsFinal -version > output

grep '.*RAMPercentage.*' output
