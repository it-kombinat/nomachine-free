FROM debian:jessie


ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update 

RUN apt-get update && apt-get install -y vim xterm pulseaudio cups curl
ENV NOMACHINE_VERSION 5.1.54
ENV NOMACHINE_MD5 034f563af6d610332a7e2c8f2c30adb8

RUN apt-get install -y  mate-desktop-environment-core

RUN curl -fSL "http://download.nomachine.com/download/5.1/Linux/nomachine_${NOMACHINE_VERSION}_1_amd64.deb" -o nomachine.deb \
&& echo "${NOMACHINE_MD5} *nomachine.deb" | md5sum -c - \
&& dpkg -i nomachine.deb \
&& groupadd -r nomachine -g 433 \
&& useradd -u 431 -r -g nomachine -d /home/nomachine -s /bin/bash -c "NoMachine" nomachine \
&& mkdir /home/nomachine \
&& chown -R nomachine:nomachine /home/nomachine \
&& echo 'nomachine:nomachine' | chpasswd


COPY nxserver.sh /

ENTRYPOINT ["/nxserver.sh"]
