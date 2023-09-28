FROM amazoncorretto:11

LABEL author="Docker"

LABEL organization="Docker"

LABEL project="Demo"

# Copy from local file on Docker host into docker image

COPY .

EXPOSE 8080

CMD ["java", "-jar", "spring-petclinic-2.4.2.jar"]

