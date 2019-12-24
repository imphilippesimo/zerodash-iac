FROM jenkins/jenkins:lts

#RUN version=2.89 && sha=$(curl -q -fsSL "https://repo.jenkins-ci.org/releases/org/jenkins-ci/main/jenkins-war/${version}/jenkins-war-${version}.war.sha256" )
#
ENV ZERODASH_DB_HOST=35.174.133.79\
    ZERODASH_DB_PORT=3307\
    ZERODASH_DB_NAME=zerodash\
    ZERODASH_DB_USER=zerodash\
    ZERODASH_DB_PASSWORD=zerodash
#    KEY_STORE=~/keystore

USER root
RUN apt-get update && apt-get install -y libltdl7 && rm -rf /var/lib/apt/lists/*
#COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
#RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
USER jenkins

#RUN mkdir -p ~/keystore
##The file api-6321041036636787156-617186-2030f42a00bb.json must be present at the same level of this Dockerfile
#ADD api-6321041036636787156-617186-2030f42a00bb.json  /keystore/key.json
#VOLUME /keystore