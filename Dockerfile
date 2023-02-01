FROM tomcat:11.0-jre11

WORKDIR /usr/local/tomcat/webapps
COPY WebApp.war ROOT.war
