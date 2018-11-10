FROM ubuntu

USER root
#RUN cat /etc/*release
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y 
RUN apt-get upgrade -y 
RUN apt-get install -y git build-essential libcurl4-gnutls-dev libgnutls28-dev python3-dev wget
RUN apt-get clean 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python3-pip python3-dnspython python3-psutil python3-redis python3-requests python3-termstyle python3-dateutil python3-tz python3-openssl cron bash-completion jq systemd apache2  php-pear php-fpm php-dev php-zip php-curl php-xmlrpc php-gd php-mysql php-mbstring php-xml libapache2-mod-php git redis-server curl sudo nano
RUN rm -rf /var/lib/apt/lists/ /tmp/ /var/tmp/*

RUN wget "https://download.opensuse.org/repositories/home:/sebix:/intelmq/xUbuntu_18.04/all/intelmq_1.1.0-1_all.deb"

RUN dpkg -i intelmq_1.1.0-1_all.deb
RUN which intelmqctl

#RUN ls -lR /var/www/html/ 

#RUN add-apt-repository 'deb https://packages.ubuntu.com/bionic bionic main' 
#sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/sebix:/intelmq/xUbuntu_18.04/ /' > /etc/apt/sources.list.d/home:sebix:intelmq.list"

RUN mkdir /tmp && chmod -R 777 /tmp
#RUN cat /etc/apache2/sites-available/000-default.conf
#ADD apache.conf /etc/apache2/sites-enabled/000-default.conf


RUN ls -als /var/www/html/


## APACHE SERVER



# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Expose apache.
EXPOSE 80

# Copy this repo into place.
RUN cd /var/www/html/ && git clone https://github.com/SaGeApps/intelmq-manager.git
RUN chmod -R a+x /var/www/html/
RUN chown www-data -R /var/www/html/
RUN rm /var/www/html/index.html
RUN usermod -G www-data root
RUN echo 'www-data ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN cat /etc/sudoers
# Update the default apache site with the config we created.
ADD apache.conf /etc/apache2/sites-enabled/000-default.conf
RUN touch /var/log/intelmq/intelmqctl.log

RUN echo "alias python=python3" >> /etc/bash.bashrc 
RUN echo "alias intelmq=intelmqctl" >> /etc/bash.bashrc 
RUN echo "service apache2 restart" >> /etc/bash.bashrc 

RUN chmod 777 /etc/intelmq/BOTS
RUN chmod 777 /etc/intelmq/defaults.conf
RUN chmod 777 /etc/intelmq/harmonization.conf
RUN chmod 777 /etc/intelmq/pipeline.conf
RUN chmod 777 /etc/intelmq/runtime.conf
RUN chmod 777 /var/www/html/intelmq-manager/debian/intelmq.conf
RUN chmod 777 /var/www/html/intelmq-manager/debian/positions.conf
RUN usermod -G root intelmq
RUN usermod -G root www-data

RUN chmod 777 /var/log/intelmq/intelmqctl.log

# By default start up apache in the foreground, override with /bin/bash for interative.
CMD redis-server 
CMD /usr/sbin/apache2ctl -D FOREGROUND

