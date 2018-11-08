## OG SET


For xUbuntu 18.04 run the following:
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/sebix:/intelmq:/unstable/xUbuntu_18.04/ /' > /etc/apt/sources.list.d/home:sebix:intelmq:unstable.list"
sudo apt-get update
sudo apt-get install intelmq

##You can add the repository key to apt. Keep in mind that the owner of the key may distribute updates, packages and repositories that your system will trust (more information). To add the key, run:
wget -nv https://download.opensuse.org/repositories/home:sebix:intelmq:unstable/xUbuntu_18.04/Release.key -O Release.key
sudo apt-key add - < Release.key
sudo apt-get update


For xUbuntu 16.04 run the following:
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/sebix:/intelmq:/unstable/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/home:sebix:intelmq:unstable.list"
sudo apt-get update
sudo apt-get install intelmq






##SET 1

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



## SET2

apt-get update
apt-get upgrade

apt-get install python3 python3-pip
apt-get install git build-essential libcurl4-gnutls-dev libffi-dev

cd /tmp
apt-get install gcc python-dev
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
pip install psutil

root@UBUNTU14-VM:~$ apt-get install redis-server

git clone https://github.com/certtools/intelmq.git /tmp/intelmq
cd /tmp/intelmq
  
pip3 install -r REQUIREMENTS
python3.4 setup.py install
  

useradd -d /opt/intelmq -U -s /bin/bash intelmq
echo 'export PATH="$PATH:$HOME/bin"' > /opt/intelmq/.profile
chmod -R 0770 /opt/intelmq
chown -R intelmq.intelmq /opt/intelmq
echo 'export INTELMQ_PYTHON=/usr/bin/python3.4' >> /opt/intelmq/.profile
