#!/bin/sh

echo 'DbAccess|Iniciando a instalação do DbAccess'

yum update -y 
yum install -y wget
yum install -y unzip
yum install -y tar
yum install -y epel-release

echo 'DbAccess|Criando estrutura de pastas'

mkdir -p /dbaccess 
mkdir -p /protheus_sync/logs
cd /dbaccess 

echo 'DbAccess|Realizando download dos artefatos'
wget https://arte.engpro.totvs.com.br/tec/dbaccess/linux/64/published/dbaccess.tar.gz 

tar -xvzf dbaccess.tar.gz 
cp multi/dbaccess64 dbaccess64
cp multi/dbaccess64.so dbaccess64.so

rm -f *.tar.gz

echo 'DbAccess|Iniciando configuração do DbAccess'
cp /rootfs/machine/dbaccess.ini .
sed -i -e 's/\r$//' dbaccess.ini

cp /rootfs/machine/usr/local/bin/init-dbaccess.sh /usr/local/bin/init-dbaccess.sh
sed -i -e 's/\r$//' /usr/local/bin/init-dbaccess.sh
	
cp /rootfs/machine/etc/systemd/init-dbaccess.service /etc/systemd/init-dbaccess.service 
sed -i -e 's/\r$//' /etc/systemd/init-dbaccess.service 

chmod 664 /etc/systemd/init-dbaccess.service 

echo 'DbAccess|Subindo serviço do dbaccess'
systemctl daemon-reload 
systemctl enable /etc/systemd/init-dbaccess.service 
systemctl start init-dbaccess.service

echo 'DbAccess|Instalação completa'
