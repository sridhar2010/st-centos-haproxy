FROM centos:centos7
MAINTAINER schandrasekaran@axway.com

RUN yum -y update; yum clean all;
RUN yum -y install sudo net-tools haproxy telnet which unzip wget expect cronie; yum clean all

#install application pre-requisites
RUN yum -y install glusterfs perl perl-Data-Dumper glibc.i686 libgcc.i686 ncurses-libs.i686 libstdc++.i686 zlib.i686 libaio.i686 compat-libstdc++-33 compat-db47 libaio; yum clean all;

RUN echo "root:axway" | chpasswd

#setup non-root user
RUN adduser axway
RUN usermod -aG wheel axway
RUN echo "axway:axway" | chpasswd
RUN echo "axway    ALL=(ALL)       ALL" >> /etc/sudoers.d/axway

#VOLUME /axwayShare
#VOLUME /glusterdata

EXPOSE 22

COPY haproxy.cfg /etc/haproxy/haproxy.cfg

RUN mkdir -p /axwayShare
RUN mkdir -p /appShare

CMD while true; do sleep 1; done
