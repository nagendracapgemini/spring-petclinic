FROM amazoncorretto:11

LABEL author="Docker"

LABEL organization="Docker"

LABEL project="Demo"

WORKDIR /app

# Copy from local file on Docker host into docker image

COPY spring-petclinic-*.jar /app/

EXPOSE 8080

CMD ["java", "-jar", "/spring-petclinic-*.jar"]

