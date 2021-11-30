#Base Image - maven
FROM maven:3-jdk-11 as build-step
RUN mkdir /app
WORKDIR /app
COPY pom.xml /app
COPY src /app/src
RUN mvn clean
RUN mvn package

#Base Image - tomcat
FROM tomcat
COPY --from=build-step /app/target/WebAppCal-1.4.0.war /usr/local/tomcat/webapps/ROOT.war
