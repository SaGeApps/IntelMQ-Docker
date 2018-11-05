FROM python:3.4

RUN apt-get update -y && \
    apt-get upgrade -y && \
	apt-get install -y git build-essential libcurl4-gnutls-dev libgnutls28-dev python3-dev && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/ /tmp/ /var/tmp/*
	
RUN sh -c "echo 'deb http://download.opensuse.org/repositories/home:/sebix:/intelmq/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/home:sebix:intelmq.list" && \
apt-get update -y && \
apt-get install php-pear php-fpm php-dev php-zip php-curl php-xmlrpc php-gd php-mysql php-mbstring php-xml libapache2-mod-php apache2 intelmq -y --allow-unauthenticated && \
chmod 777 /var/log/intelmq/intelmqctl.log && \
echo "intelmq    ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers" && \
echo "www-data    ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers" && \


USER root
RUN cd /var/www/html/ && git clone 'https://github.com/certtools/intelmq-manager.git' && chmod -R a+x . && service apache2 restart
CMD ["sh", "/usr/bin/intelmqctl start"]