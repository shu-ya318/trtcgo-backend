# ===== Stage 1: Build the app =====
FROM harbor.mli.com.corp/rhscl/ubi8/openjdk-17:1.20-2 AS build

WORKDIR /home/jboss

COPY --chown=185:0 pom.xml .

# RUN mvn dependency:go-offline

COPY --chown=185:0 src/ ./src/

RUN mvn clean package -DskipTests

# ===== Stage 2: Final runtime image =====
FROM registry.access.redhat.com/ubi8/openjdk-17-runtime:1.20-2

COPY --from=build --chown=185:0 /home/jboss/target/trtcgo-backend.jar ./trtcgo-backend.jar

EXPOSE 8080

CMD ["java", "-jar", "trtcgo-backend.jar"]
