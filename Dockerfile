FROM eclipse-temurin:21-jdk-alpine AS build
WORKDIR /app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
RUN chmod +x mvnw && ./mvnw dependency:go-offline -q

COPY src src
RUN ./mvnw package -DskipTests -q

FROM eclipse-temurin:21-jdk-alpine
WORKDIR /app

RUN mkdir -p /uploads

COPY --from=build /app/target/*.war app.war

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.war"]
