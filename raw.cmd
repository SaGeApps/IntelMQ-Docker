apt-get install -y git build-essential libcurl4-gnutls-dev libgnutls28-dev python3-dev 
rm -rf /var/lib/apt/lists/ /tmp/ /var/tmp/*

git clone https://github.com/certtools/intelmq.git /tmp/intelmq
cd /tmp/intelmq

pip3 install -r REQUIREMENTS && pip3 install .
mv /opt/intelmq/etc/examples/*.conf /opt/intelmq/etc/
cp config/* /opt/intelmq/etc/

useradd -d /opt/intelmq -U -s /bin/bash intelmq && \
chmod -R 0770 /opt/intelmq && \
chown -R intelmq.intelmq /opt/intelmq

cp intelmq_docker /usr/local/bin/

USER intelmq
WORKDIR /opt/intelmq
CMD ["sh", "/usr/local/bin/intelmq_docker"]
