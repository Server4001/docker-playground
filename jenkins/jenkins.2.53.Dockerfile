FROM jenkins/jenkins:2.53-alpine
MAINTAINER Brice Bentler "me@bricebentler.com"

USER root

RUN mkdir /var/log/jenkins
RUN mkdir /var/cache/jenkins

RUN chown -R jenkins:jenkins /var/log/jenkins
RUN chown -R jenkins:jenkins /var/cache/jenkins

USER jenkins

ENV JAVA_OPTS="-Xmx8192m"
