FROM ubuntu:22.04
RUN apt update
RUN apt install openjdk-11-jdk wget -y
RUN wget java11-examples-0.0.1-SNAPSHOT.jar
EXPOSE 8080
CMD ["java", "-jar", "/java11-examples-0.0.1-SNAPSHOT.jar"]

