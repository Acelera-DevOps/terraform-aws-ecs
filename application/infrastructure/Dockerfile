# =============================================================================
# Stage 1: Build Stage (Eclipse Temurin 21 JDK Alpine)
# =============================================================================
FROM eclipse-temurin:21-jdk-alpine AS builder

WORKDIR /workspace

# Copy Maven wrapper and POM first to leverage Docker layer cache
COPY mvnw ./
COPY .mvn .mvn
COPY pom.xml ./
RUN chmod +x mvnw && ./mvnw dependency:go-offline -B

# Copy application source and build executable JAR
COPY src ./src
RUN ./mvnw clean package -DskipTests -B

# =============================================================================
# Stage 2: Hardened Production Runtime (Eclipse Temurin 21 JRE Alpine)
# =============================================================================
FROM eclipse-temurin:21-jre-alpine AS runtime

LABEL org.opencontainers.image.title="springbootapp" \
      org.opencontainers.image.description="Spring Boot 3.3 / Java 21 microservice on AWS ECS Fargate" \
      org.opencontainers.image.authors="Erik Tonon <https://eriktonon.com>"

# Create non-root group and user (UID/GID 10001)
RUN addgroup -S -g 10001 appgroup && \
    adduser -S -u 10001 -G appgroup appuser

WORKDIR /app

# Copy compiled artifact or pre-built JAR with non-root ownership
COPY --from=builder --chown=appuser:appgroup /workspace/target/*.jar /app/springbootapp.jar

USER appuser:appgroup

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=20s --retries=3 \
  CMD wget -qO- http://localhost:8080/actuator/health || exit 1

ENTRYPOINT ["java", "-XX:+UseContainerSupport", "-XX:MaxRAMPercentage=75.0", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/springbootapp.jar"]
