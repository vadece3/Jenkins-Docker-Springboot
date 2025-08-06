FROM eclipse-temurin:24-jdk-alpine
WORKDIR /app
COPY target/demo-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]


# Install Maven
RUN apk update && apk add maven git

# Verify installations
RUN java -version && mvn -version
