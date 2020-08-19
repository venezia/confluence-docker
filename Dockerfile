FROM alpine:latest

ENV CONNECTOR_VERSION mysql-connector-java-8.0.20
ENV CONNECTOR_URL https://dev.mysql.com/get/Downloads/Connector-J/${CONNECTOR_VERSION}.tar.gz

RUN apk update && \
    apk add curl openssl && \
    curl -L $CONNECTOR_URL | tar -zxv ${CONNECTOR_VERSION}/${CONNECTOR_VERSION}.jar --strip-components 1

FROM atlassian/confluence-server:7.6.2
ENV CONNECTOR_VERSION mysql-connector-java-8.0.20
COPY --from=0 /${CONNECTOR_VERSION}.jar /opt/atlassian/confluence/confluence/WEB-INF/lib/

