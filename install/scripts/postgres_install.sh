#!/bin/sh

echo 'Iniciando a instalação do PostgreSQL'

yum update -y 
yum install -y wget
yum install -y unzip
yum install -y tar
yum install -y epel-release

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

# criando o usuario padrao
su - postgres -s /bin/bash -c "/usr/bin/createuser protheus"

# criando banco de dados
su - postgres -s /bin/bash -c "/usr/bin/createdb -E LATIN1 -T template0 --lc-collate=pt_BR.ISO-8859-1 --lc-ctype=pt_BR.ISO-8859-1 protheus_system"
su - postgres -s /bin/bash -c "/usr/bin/createdb -E LATIN1 -T template0 --lc-collate=pt_BR.ISO-8859-1 --lc-ctype=pt_BR.ISO-8859-1 protheus_db"

# configurando odbc
cat << EOF >> /etc/odbc.ini
[protheus_db]
Description=PostgreSQL connection to protheus_db
Driver=PostgreSQL
Database=protheus_db
Servername=192.168.56.100
Port=5432
ReadOnly=0
MaxLongVarcharSize=2000
UnknownSizes=2
UseServerSidePrepare=1

[protheus_system]
Description=PostgreSQL connection to protheus_system
Driver=PostgreSQL
Database=protheus_system
Servername=192.168.56.100
Port=5432
ReadOnly=0
MaxLongVarcharSize=2000
UnknownSizes=2
UseServerSidePrepare=1

EOF


# criação da pasta do dbaccess
mkdir -p /dbaccess
mkdir -p /logs
cd /dbaccess

wget https://arte.engpro.totvs.com.br/tec/dbaccess/linux/64/published/dbaccess.tar.gz && \
tar -xvzf dbaccess.tar.gz && \
cp multi/dbaccess64 dbaccess64 && \
cp multi/dbaccess64.so dbaccess64.so



	
	