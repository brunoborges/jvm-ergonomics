# JVM Ergonomics

This repository runs a script that checks the JVM Ergonomics selection of the Garbage Collector when up to 1791MB of memory is available to containers. The expected selection is `SerialGC`.

This repo checks versions `11` and `17` of the following JDKs:

- Azul Zulu
- BellSoft Liberica
- Eclipse Temurin
- Microsoft Build of OpenJDK
- Oracle OpenJDK

For more information, visit [Java Containerization Strategies](https://docs.microsoft.com/en-us/azure/developer/java/containers/).
