FROM jenkins/jenkins:lts


ENV DB_HOST=35.174.133.79\
    DB_PORT=3307\
    DB_NAME=zerodash\
    DB_USER=zerodash\
    DB_PASSWORD=zerodash

USER root
RUN apt-get update && apt-get install -y libltdl7 && rm -rf /var/lib/apt/lists/*

USER jenkins
