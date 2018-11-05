FROM ubuntu

USER root
#RUN cat /etc/*release
RUN apt update -y 
RUN apt upgrade -y 
RUN apt install -y git build-essential libcurl4-gnutls-dev libgnutls28-dev python3-dev wget
RUN apt clean 
RUN apt install -y python3-pip python3-dnspython python3-psutil python3-redis python3-requests python3-termstyle python3-tz python3-dateutil
RUN apt install -y git redis-server
RUN rm -rf /var/lib/apt/lists/ /tmp/ /var/tmp/*
	
#RUN echo 'deb http://download.opensuse.org/repositories/home:/sebix:/intelmq:/unstable/xUbuntu_18.04/ /' > /etc/apt/sources.list.d/home:sebix:intelmq:unstable.list
#RUN apt update -y
#RUN apt install intelmq -y 

RUN wget "https://download.opensuse.org/repositories/home:/sebix:/intelmq/xUbuntu_18.04/all/intelmq_1.1.0-1_all.deb"

RUN dpkg -i intelmq_1.1.0-1_all.deb