FROM tomcat:9.0-jdk17-temurin

# Remove default web apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file
COPY Electricity_Billing_System_1.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
