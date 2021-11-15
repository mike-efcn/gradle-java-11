FROM eclipse-temurin:11.0.13_8-jdk-alpine as build
WORKDIR /service
COPY ./service/gradle/ ./gradle/
COPY ./service/gradlew* ./service/*.gradle ./
RUN ./gradlew clean build --no-daemon || true
COPY ./service/src/ ./src/
RUN ./gradlew clean build --no-daemon

FROM eclipse-temurin:11.0.13_8-jre-alpine
WORKDIR /app
COPY --from=build /service/build/libs/*.jar ./app.jar
CMD ["java", "-jar", "app.jar"]
