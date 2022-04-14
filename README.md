# JVM Ergonomics

[![JVM Ergonomics Checker](https://github.com/brunoborges/jvm-ergonomics/workflows/JVM%20Ergonomics%20Checker/badge.svg)](https://github.com/brunoborges/jvm-ergonomics/actions/workflows/build.yml)

This repository runs a script that checks the JVM Ergonomics selection of the Garbage Collector when up to 1791MB of memory is available to containers. Unless a specific build of OpenJDK has different settings/ergonomics, the expected selection for this test is `SerialGC` for memory up to 1791MB, and G1GC if more.

This repo checks versions `11` and `17` of the following JDKs:

- Azul Zulu
- BellSoft Liberica
- Eclipse Temurin
- Microsoft Build of OpenJDK
- Oracle OpenJDK

For more information, visit [Java Containerization Strategies](https://docs.microsoft.com/en-us/azure/developer/java/containers/).

## GC Ergonomic Selection

The ergonomic selection of a garbage collector in the HotSpot JVM happens on the following classes:

- JDK 17: https://github.com/openjdk/jdk17u/blob/master/src/hotspot/share/gc/shared/gcConfig.cpp#L98
- JDK 11: https://github.com/openjdk/jdk11u/blob/master/src/hotspot/share/gc/shared/gcConfig.cpp#L108

In both cases, the selection of the GC is dependent upon the JVM understanding of whether it is running on a `Server Class Machine` or a `Client Class Machine`. This distinction is done in the following classes:

- JDK 17: https://github.com/openjdk/jdk17u/blob/master/src/hotspot/share/runtime/os.cpp#L1686
- JDK 11: https://github.com/openjdk/jdk11u/blob/master/src/hotspot/share/runtime/os.cpp#L1696

As you can see on the source code, the JVM considers a machine (or environment, such as a container) with 1792MB or more of memory available, and two or more available processors, as a `Server Class Machine`; otherwise, it is a `Client Class Machine`.
