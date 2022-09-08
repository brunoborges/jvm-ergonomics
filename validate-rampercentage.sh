#!/bin/bash
imagerepo=$1
imageversion=$2

containerimage=$1:$2

# Check if Microsoft Build of OpenJDK
if [[ $imagerepo == "mcr.microsoft.com/openjdk/jdk" ]]; then
  containerimage=$containerimage-ubuntu
fi

echo "Pull container image ${containerimage}..."
docker pull $containerimage

echo "Running image $containerimage ..."

# Test MaxRAMPercentage
echo "-- Test for MaxRAMPercentage..."
docker run --memory=128m $containerimage java -XX:+PrintFlagsFinal -version 2&1> output

grep 'RAMPercentage' output
