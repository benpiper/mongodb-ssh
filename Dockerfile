FROM debian:stable-slim
LABEL maintainer="ben@benpiper.com"
LABEL Description="An OpenSSH server with MongoDB Shell installed."

RUN apt-get update \
&& apt-get install -y gnupg wget openssh-server sudo curl iputils-ping \
&& useradd -m mongossh \
&& echo "mongossh:Wavey15Admins" | chpasswd \
&& adduser mongossh sudo \
&& usermod --shell /bin/bash mongossh \
&& wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | apt-key add - \
&& echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list \
&& apt-get update \
&& apt-get install -y mongodb-mongosh \
&& service ssh start

EXPOSE 22/tcp

ENTRYPOINT ["/usr/sbin/sshd","-D","-e"]
