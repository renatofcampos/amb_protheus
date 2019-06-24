#!/bin/sh

PG_VERSION=10
DB_USER=protheus
DB_PASS=protheus
DB_NAME_SF=protheus_system
DB_NAME_DB=protheus_db


print_db_usage () {
  echo "PostgreSQL esta instalado e poderá ser acessado pela porta: 15432 (forward do vagrant)"
  echo "  Host: localhost"
  echo "  Port: 15432"
  echo "  Database 1: $DB_NAME_SF"
  echo "  Database 2: $DB_NAME_DB"
  echo "  Username: $DB_USER"
  echo "  Password: $DB_PASS"
  echo ""
  echo "Admin possui acesso ao postgres via a VM:"
  echo "  vagrant ssh"
  echo "  sudo su - postgres"
  echo ""
  echo "psql possui acesso ao database via user VM:"
  echo "  vagrant ssh"
  echo "  sudo su - postgres"
  echo "  PGUSER=$DB_USER PGPASSWORD=$DB_PASS psql -h localhost $DB_NAME_SF"
  echo ""
  echo "Variavel do ambiente liberado em: "
  echo "  DATABASE_URL=postgresql://$DB_USER:$DB_PASS@localhost:15432/$DB_NAME_SF"
  echo ""
  echo "psql:"
  echo "  PGUSER=$DB_USER PGPASSWORD=$DB_PASS psql -h localhost -p 15432 $DB_NAME_SF"
}

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
cp . /
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

echo "Criando bancos de dados para utilização no protheus"

cat << EOF | su - postgres -c psql
CREATE ROLE vagrant SUPERUSER LOGIN PASSWORD 'vagrant';
CREATE ROLE $DB_USER SUPERUSER LOGIN PASSWORD '$DB_PASS';


-- Create the database user:
-- CREATE USER $DB_USER WITH PASSWORD '$DB_PASS';

-- Cria o primeiro banco
CREATE DATABASE $DB_NAME_SF WITH OWNER=$DB_USER
                                 LC_COLLATE='C'
                                 LC_CTYPE='C'
                                 ENCODING='LATIN1'
                                 TEMPLATE=template0;

-- Cria o primeiro banco
CREATE DATABASE $DB_NAME_DB WITH OWNER=$DB_USER
                                 LC_COLLATE='C'
                                 LC_CTYPE='C'
                                 ENCODING='LATIN1'
                                 TEMPLATE=template0;

EOF

#echo "Alterando senhas para utilização no dbaccess"
#cat << EOF | su - postgres -c psql $DB_NAME_DB 
#alter user $DB_USER with encrypted password '$DB_PASS';
#EOF
#
#cat << EOF | su - postgres -c psql $DB_NAME_FS 
#alter user $DB_USER with encrypted password '$DB_PASS';
#EOF

echo "Configurando o postgres para utilização do dbaccess"

PG_CONF="/var/lib/pgsql/$PG_VERSION/data/postgresql.conf"
PG_HBA="/var/lib/pgsql/$PG_VERSION/data/pg_hba.conf"

# Edit postgresql.conf to change listen address to '*':
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" "$PG_CONF"

# Append to pg_hba.conf to add password auth:
echo "host    all             all             all                     trust" >> "$PG_HBA"
sed -i "s/local   all             all                                     peer/local   all             all                                     trust/" "$PG_HBA"

systemctl restart postgresql-10 

echo "Instalando ODBCs"
systemctl stop postgresql-10

# realiza a instalação do Driver do ODBC
odbcinst -i -d -f /install/manifests/etc/odbcinst.ini

# realiza a instalação do ODBC
odbcinst -i -s -f /install/manifests/etc/odbc.ini

systemctl start postgresql-10

echo 'Instalação do PostgreSQL concluida'
echo ""

print_db_usage