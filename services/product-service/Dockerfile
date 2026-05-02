# Use the lightweight JRE for the final image
FROM eclipse-temurin:21-jre-jammy
WORKDIR /app

# Copy the JAR already built by GitHub Actions from the target folder
COPY target/product-service-0.0.1-SNAPSHOT.jar app.jar

# Product Service runs on 8081
EXPOSE 8081

ENTRYPOINT ["java", "-jar", "app.jar"]