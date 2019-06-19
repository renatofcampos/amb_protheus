#!/bin/sh

echo 'Protheus|Iniciando a instalação das bibliotecas necessárias'

yum update -y 

yum install -y wget 
yum install -y unzip 
yum install -y tar 
yum install -y telnet 
yum install -y vim 
yum install -y epel-release  
yum install -y binutils.x86_64 compat-libcap1.x86_64 gcc.x86_64 gcc-c++.x86_64 glibc.i686 glibc.x86_64 glibc-devel.i686 glibc-devel.x86_64 ksh compat-libstdc++-33 libaio.i686 libaio.x86_64 libaio-devel.i686 libaio-devel.x86_64 libgcc.i686 libgcc.x86_64 libstdc++.i686 libstdc++.x86_64 libstdc++-devel.i686 libstdc++-devel.x86_64 libXi.i686 libXi.x86_64 libXtst.i686 libXtst.x86_64 make.x86_64 sysstat.x86_64 which 
yum install -y puppet-server 
yum clean all     
rm -rf /var/cache/yum    

sed '/(soft nofile)/d' /etc/security/limits.conf    
sed '/(hard nofile)/d' /etc/security/limits.conf    
echo 'soft nofile 32768' >> /etc/security/limits.conf    
echo 'hard nofile 32768' >> /etc/security/limits.conf    

chsh -s /bin/bash vagrant

echo 'Protheus|Iniciando a instalação do Protheus'

# criando a estrutura das pastas para instalação do protheus
# este script busca dentro do arte da engenharia, todos os componentes atualizados para provisionar a base.
# uma vez provisionado, o ambiente sempre trabalhará com o ultimo rpo (d-1) disponibilizado, caso queira manter o teste
echo 'criando estrutura de pastas'
mkdir -p /protheus 
mkdir -p /protheus/apo 
mkdir -p /protheus/bin 
mkdir -p /protheus/bin/appserver 
mkdir -p /protheus/protheus_data 
mkdir -p /protheus/protheus_data/data 
mkdir -p /protheus/protheus_data/systemload 
mkdir -p /protheus/protheus_data/systemload/updmenu 
mkdir -p /protheus/protheus_data/web 

# _db --> dicionario no banco
# _system --> dicionario no system
# configurar o ini do protheus (protheus_ini/protheus_appserver.ini) todos os ambientes para direcionar para estas pastas.
# no caso do mssqlserver, deve-se ter o mesmo instalado em sua maquina, ou direcionado para um odbc instalado na rede
# IMPORTANTE: Todas as vezes que provisionar a maquina, os dados de SX serão apagados e deverão ser recriados novamente, desta forma, recomendamos sempre utilizar o ambiente db
mkdir -p /protheus/protheus_data/system 	
mkdir -p /protheus/protheus_data/system/modelo 	
mkdir -p /protheus/protheus_data/system/mssqlserver_db 	
mkdir -p /protheus/protheus_data/system/mssqlserver_system	
mkdir -p /protheus/protheus_data/system/oracle_db 	
mkdir -p /protheus/protheus_data/system/oracle_system	
mkdir -p /protheus/protheus_data/system/postgresql_db 	
mkdir -p /protheus/protheus_data/system/postgresql_system	
mkdir -p /protheus/protheus_data/system/db2_db 	
mkdir -p /protheus/protheus_data/system/db2_system	

########## ARTEFATOS DO BINARIO ##########
# para realizar o download dos artefatos, utilizamos os nomes comuns disponibilizados pela engenharia, desta forma, a tendencia de manutenção no mesmo fica reduzida.
echo 'realizando download dos arquivos de instalação'
cd /protheus/bin/appserver 
wget https://arte.engpro.totvs.com.br/tec/appserver/lobo_guara/linux/64/published/appserver.tar.gz 
tar -xvzf appserver.tar.gz 
rm -f *.tar.gz 
chmod 777 *.so 

wget https://arte.engpro.totvs.com.br/tec/smartclientwebapp/lobo_guara/linux/64/published/webapp.tar.gz 
tar -xvzf webapp.tar.gz 
rm -f *.tar.gz 

########## RPO ##########
# Faremos um scrit para download automatico do RPO apos o provisionamento das maquinas
# para a primeira instalação, sempre copiamos o rpo atual.
cd /protheus/apo 
wget https://arte.engpro.totvs.com.br/protheus/padrao/published/repositorio/lobo_guara/tttp120.rpo 


########## ARTEFATOS DO SYSTEM ##########
cd /protheus/protheus_data/system/modelo 
wget https://arte.engpro.totvs.com.br/protheus/padrao/published/dicionario/arquivos_de_configuracao/19-02-14-ARQUIVOS_CONFIGURACAO_FISCAL_12_1_23.ZIP 
wget https://arte.engpro.totvs.com.br/protheus/padrao/published/dicionario/arquivos_de_configuracao/19-02-15-ARQUIVOS_PORTAL_E_WIZARD_SIGAPLS_12.1.23.ZIP 
wget https://arte.engpro.totvs.com.br/protheus/padrao/published/dicionario/stored_procedures/19-02-15-STORED_PROCEDURES_TODAS_V12.1.23.ZIP 
wget https://arte.engpro.totvs.com.br/protheus/padrao/published/dicionario/menus/completo/19-02-15-BRA-MENUS_12_1_23.ZIP  
unzip -o 19-02-14-ARQUIVOS_CONFIGURACAO_FISCAL_12_1_23.ZIP 
unzip -o 19-02-15-ARQUIVOS_PORTAL_E_WIZARD_SIGAPLS_12.1.23.ZIP 
unzip -o 19-02-15-STORED_PROCEDURES_TODAS_V12.1.23.ZIP 
unzip -o 19-02-15-BRA-MENUS_12_1_23.ZIP 
unzip -o 'arquivos CSV.zip' 
unzip -o 'arquivos JS.zip' 
rm -f *12_1_23.ZIP 

cp -f -r * ../mssqlserver_db 
cp -f -r * ../oracle_db 
cp -f -r * ../postgresql_db 
cp -f -r * ../db2_db 
cp -f -r * ../mssqlserver_system
cp -f -r * ../oracle_system
cp -f -r * ../postgresql_system
cp -f -r * ../db2_system

########## ARTEFATOS DO SYSTEMLOAD ##########
cd /protheus/protheus_data/systemload 
wget https://arte.engpro.totvs.com.br/protheus/padrao/published/dicionario/dicionario_de_dados/completo/19-02-15-BRA-DICIONARIOS_COMPL_12_1_23.ZIP	 
wget https://arte.engpro.totvs.com.br/protheus/padrao/published/dicionario/dicionario_de_dados/diferencial/19-02-15-BRA-DICIONARIOS_DIF_12_1_23.ZIP 
wget https://arte.engpro.totvs.com.br/protheus/padrao/published/dicionario/help_de_campo/completo/19-02-14-BRA-HELPS_COMPL_12_1_23.ZIP 
unzip -o 19-02-15-BRA-DICIONARIOS_COMPL_12_1_23.ZIP 
unzip -o 19-02-15-BRA-DICIONARIOS_DIF_12_1_23.ZIP 
unzip -o 19-02-14-BRA-HELPS_COMPL_12_1_23.ZIP 
rm -f *12_1_23.ZIP 
cd /protheus/protheus_data/systemload/bra 
cp * .. 
cd .. 
rm bra/* -f  
rmdir bra 

cd /protheus/protheus_data/systemload/updmenu 
wget https://arte.engpro.totvs.com.br/protheus/padrao/published/dicionario/menus/completo/19-02-15-BRA-MENUS_12_1_23.ZIP  
unzip -o 19-02-15-BRA-MENUS_12_1_23.ZIP 
rm -f *12_1_23.ZIP 

cd /protheus/protheus_data/web 
wget https://arte.engpro.totvs.com.br/protheus/padrao/published/dicionario/web-files/19-02-15-WEB-FILES-P12.1.23.ZIP 
unzip -o 19-02-15-WEB-FILES-P12.1.23.ZIP 
rm -f *12.1.23.ZIP

echo 'Protheus|Instalação do Protheus concluida'

echo 'Protheus|Instalando serviços dentro da maquina'

cp /install/manifests/init-protheus.sh /usr/local/bin/init-protheus.sh 
cp /install/manifests/init-protheus-rest.sh /usr/local/bin/init-protheus-rest.sh 
cp /install/manifests/init-lockserver.sh /usr/local/bin/init-lockserver.sh 

sed -i -e 's/\r$//' /usr/local/bin/*.sh 

chmod +x /usr/local/bin/* /usr/bin/* 

echo export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/protheus/bin/appserver:/usr/local/bin 

cp /install/manifests/init-protheus.service /etc/systemd/init-protheus.service 
cp /install/manifests/init-protheus-rest.service /etc/systemd/init-protheus-rest.service 
cp /install/manifests/init-lockserver.service /etc/systemd/init-lockserver.service 

sed -i -e 's/\r$//' /etc/systemd/init-protheus.service 
sed -i -e 's/\r$//' /etc/systemd/init-protheus-rest.service 
sed -i -e 's/\r$//' /etc/systemd/init-lockserver.service 

chmod 664 /etc/systemd/init-protheus.service 
chmod 664 /etc/systemd/init-protheus-rest.service 
chmod 664 /etc/systemd/init-lockserver.service 

systemctl daemon-reload 
systemctl enable /etc/systemd/init-protheus.service 
systemctl enable /etc/systemd/init-protheus-rest.service 
systemctl enable /etc/systemd/init-lockserver.service 

echo 'Protheus|Serviços instalados, será chamado dentro da triger da VM'
# systemctl start init-protheus.service
# systemctl start init-protheus-rest.service
# systemctl start init-lockserver.service
