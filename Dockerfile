FROM jenkins/jenkins:alpine-jdk17

MAINTAINER trion development GmbH "info@trion.de"

ENV JENKINS_USER=jenkins CASC_JENKINS_CONFIG=/var/jenkins_home/config.yaml
USER root
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint.sh"]
RUN apk --no-cache add shadow su-exec

RUN  \
  curl https://download.docker.com/linux/static/stable/x86_64/docker-20.10.17.tgz | tar xvz -C /tmp/ && \
  mv /tmp/docker/docker /usr/bin/docker

COPY plugins.txt config.yaml /provisioning/
COPY entrypoint.sh /usr/local/bin/

RUN ["chmod", "+x", "/usr/local/bin/entrypoint.sh"]
