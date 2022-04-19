#!/bin/bash
imagerepo=$1
imageversion=$2

containerimage=$1:$2

# Check if Microsoft Build of OpenJDK
if [[ $imagerepo == "mcr.microsoft.com/openjdk/jdk" ]]; then
  containerimage=$containerimage-ubuntu
fi

echo "Pull container image...
docker pull $containerimage

echo "Running image $containerimage with 1791mb of memory..."

# Test SerialGC
echo "-- Test for SerialGC with 1791m..."
docker run --memory=1791m $containerimage java -XX:+PrintFlagsFinal -version > output

grep '.*SerialGC.*true.*' output

failed=0

if [[ $? == 0 ]]; then
  echo "PASSED: SerialGC is selected for 1791m"
else
  echo "FAILED: SerialGC is not selected for 1791m"
  failed=1
fi  

# Test G1GC
echo "-- Test for G1GC with 1792m..."
docker run --memory=1792m $containerimage java -XX:+PrintFlagsFinal -version > output

grep '.*G1GC.*true.*' output

if [[ $? == 0 ]]; then
  echo "PASSED: G1GC is selected for 1792m"
else
  echo "FAILED: G1GC is not selected for 1792m"
  failed=1
fi  

exit $failed
