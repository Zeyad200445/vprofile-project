FROM eclipse-temurin:21-jdk AS build-image 
RUN apt update && apt install maven -y
COPY ./ vprofile-project 
RUN cd vprofile-project && mvn install

FROM tomcat:10-jdk21
LABEL "Project"="Vprofile"
LABEL "Author"="Imran"

RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build-image target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war


EXPOSE 8080
CMD ["catalina.sh", "run"]
