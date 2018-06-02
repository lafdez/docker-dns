FROM armv7/armhf-debian

LABEL maintainer="Luis Ángel Fernández Fernández <la@zzsoft.es>"

ARG DEBIAN_FRONTEND=noninteractive

EXPOSE 53/udp 53/tcp 953/tcp 10050/tcp

RUN apt -q -y update \
&& apt -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" install apt-utils \
&& apt -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" dist-upgrade \
&& apt -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" install bind9 bind9utils bind9-host man \
&& apt -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" install wget libcurl3 libldap-2.4.2 libodbc1 \
&& wget https://github.com/imkebe/zabbix3-rpi/raw/master/zabbix-agent_3.0.2-1%2Bjessie_armhf.deb \
&& dpkg -i zabbix-agent_3.0.2-1+jessie_armhf.deb \
&& apt -q -y autoremove \
&& apt -q -y clean \
&& rm -rf /var/lib/apt/lists/* 

CMD ["/usr/sbin/named", "-f", "-u", "bind"]

