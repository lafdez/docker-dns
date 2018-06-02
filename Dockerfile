FROM debian

LABEL maintainer="Luis Ángel Fernández Fernández <la@zzsoft.es>"

ARG DEBIAN_FRONTEND=noninteractive

EXPOSE 53/udp 53/tcp 953/tcp 10050/tcp

RUN apt -q -y update \
&& apt -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" install apt-utils \
&& apt -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" dist-upgrade \
&& wget http://repo.zabbix.com/zabbix/3.4/debian/pool/main/z/zabbix-release/zabbix-release_3.4-1+stretch_all.deb \
&& dpkg -i zabbix-release_3.4-1+stretch_all.deb \
&& rm -f zabbix-release_3.4-1+stretch_all.deb \
&& apt update \
&& apt -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" install zabbix-agent \
&& apt -q -y autoremove \
&& apt -q -y clean \
&& rm -rf /var/lib/apt/lists/* 

CMD ["/usr/sbin/named", "-f", "-u", "bind"]

