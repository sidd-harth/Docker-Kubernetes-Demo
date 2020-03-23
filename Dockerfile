# Start with a base image containing Java runtime (mine java 8)
FROM openjdk:8-jdk-alpine

# Add Maintainer Info
LABEL maintainer="siddharth-b@hcl.com"

# Make port 9099 available to the world outside this container
EXPOSE 9099

# The application's jar file (when packaged)
ARG JAR_FILE=target/*.jar

# Add the application's jar to the container
ADD ${JAR_FILE} app.jar

# Run the jar file 
ENTRYPOINT ["java","-jar","/app.jar"]