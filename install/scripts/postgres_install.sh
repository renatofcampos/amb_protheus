#!/bin/sh

echo 'Iniciando a instalação do PostgreSQL'

yum update -y 
yum install -y wget
yum install -y unzip
yum install -y tar
yum install -y telnet 
yum install -y vim 
yum install -y epel-release

yum clean all

rm -rf /var/cache/yum

wget -O /usr/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64
chmod +x /usr/bin/dumb-init
COPY . /
RUN chmod +x /usr/local/bin/*

# atualização dos pacotes de atualização do centos
rpm -Uvh https://yum.postgresql.org/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm

# instalação das bibliotecas necessarias para rodar
yum install -y --setopt=protected_multilib=false libaio libaio.so.1 fontconfig freetype freetype-devel fontconfig-devel libstdc++ ld-linux.so.2 libuuid.so.1 libfontconfig.so.1 libgthread-2.0.so.0 

# instalação do postgres e ODBC
yum install -y unixODBC postgresql10-odbc postgresql10-server postgresql10
yum clean all 
rm -rf /var/cache/yum

# iniciando o banco de dados
/usr/pgsql-10/bin/postgresql-10-setup initdb
systemctl enable postgresql-10
systemctl start postgresql-10

# criando o usuario padrao (superuser)
su - postgres -s /bin/bash -c "/usr/bin/createuser protheus -s"

# criando banco de dados
su - postgres -s /bin/bash -c "/usr/bin/createdb -E LATIN1 -T template0 --lc-collate=C --lc-ctype=C protheus_system"
su - postgres -s /bin/bash -c "/usr/bin/createdb -E LATIN1 -T template0 --lc-collate=C --lc-ctype=C protheus_db"

su - postgres -s /bin/bash -c "/usr/bin/psql -U protheus protheus_db -f alter user protheus with encrypted password 'protheus'"

systemctl stop postgresql-10

# realiza a instalação do Driver do ODBC
odbcinst -i -d -f /install/manifests/etc/odbcinst.ini

# realiza a instalação do ODBC
odbcinst -i -s -f /install/manifests/etc/odbc.ini

# realizo a copia dos arquivos de configuração do postgres
sudo cp /install/manifests/var/lib/pgsql/10/data/*.conf /var/lib/pgsql/10/data/

systemctl start postgresql-10

echo 'Instalação do PostgreSQL concluida'