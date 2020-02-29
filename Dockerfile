FROM openjdk

ARG APP_NAME=''
ARG APP_VERSION=''
WORKDIR /opt
COPY target/${APP_NAME}-${APP_VERSION}.jar /opt/myapp.jar
CMD java -jar /opt/myapp.jar