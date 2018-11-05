FROM python:3.4

RUN apt-get update -y && \
    apt-get upgrade -y && \
	apt-get install -y git build-essential libcurl4-gnutls-dev libgnutls28-dev python3-dev && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/ /tmp/ /var/tmp/*
	
