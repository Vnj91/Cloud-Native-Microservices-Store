# Use a lightweight JRE for the final image
FROM eclipse-temurin:21-jre-jammy
WORKDIR /app

# The GitHub Action already built the JAR in the 'target' folder
COPY target/user-service-0.0.1-SNAPSHOT.jar app.jar

# Correct port for User Service
EXPOSE 8082

ENTRYPOINT ["java", "-jar", "app.jar"]