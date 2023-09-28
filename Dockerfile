FROM ubuntu:22.04
RUN apt update
RUN apt install openjdk-17-jdk wget -y
WORKDIR /app
COPY /var/lib/jenkins/workspace/target/spring-petclinic-*.jar app.jar
EXPOSE 8082
CMD ["java", "-jar", "app.jar"]
