# =======================
# ETAPA 1: BUILD (Maven)
# =======================
FROM maven:3.9.6-eclipse-temurin-11 AS build
WORKDIR /app

# Copiamos el pom primero para cache
COPY pom.xml .
RUN mvn -q -DskipTests dependency:go-offline

# Copiamos todo el proyecto y compilamos
COPY . .
RUN mvn -DskipTests package

# =======================
# ETAPA 2: TOMCAT
# =======================
FROM tomcat:9.0-jdk11-temurin

# Limpiamos apps por defecto
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiamos el WAR como ROOT.war
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
