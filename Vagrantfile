# sudo yum install -y --setopt=protected_multilib=false     glibc.i686     libicu     libuuid.so.1     libfontconfig.so.1     libgthread-2.0.so.0     unixODBC-devel     awscli     s3fs-fuse     && \

$script_init = <<-SCRIPT
	sudo yum install -y wget &&\
	sudo yum install -y unzip &&\
	sudo yum install -y tar &&\
	sudo yum install -y epel-release  && \
	sudo yum install -y binutils.x86_64 compat-libcap1.x86_64 gcc.x86_64 gcc-c++.x86_64 glibc.i686 glibc.x86_64 glibc-devel.i686 glibc-devel.x86_64 ksh compat-libstdc++-33 libaio.i686 libaio.x86_64 libaio-devel.i686 libaio-devel.x86_64 libgcc.i686 libgcc.x86_64 libstdc++.i686 libstdc++.x86_64 libstdc++-devel.i686 libstdc++-devel.x86_64 libXi.i686 libXi.x86_64 libXtst.i686 libXtst.x86_64 make.x86_64 sysstat.x86_64 which && \
	sudo yum install -y puppet-server &&\
	sudo yum clean all     && \
	sudo rm -rf /var/cache/yum

	sudo sed '/(soft nofile)/d' /etc/security/limits.conf
	sudo sed '/(hard nofile)/d' /etc/security/limits.conf
	sudo echo 'soft nofile 32768' >> /etc/security/limits.conf
	sudo echo 'hard nofile 32768' >> /etc/security/limits.conf
	sudo chsh -s /bin/bash vagrant
SCRIPT

$script_postgres = <<-SCRIPT
	sudo mkdir -p /totvs/dbaccess && \
	sudo mkdir -p /totvs/logs && \
	sudo cd /totvs/dbaccess && \
	sudo wget https://arte.engpro.totvs.com.br/tec/dbaccess/linux/64/published/dbaccess.tar.gz && \
	sudo tar -xvzf dbaccess.tar.gz && \
	sudo yum install postgresql-server postgresql-contrib  -y && \
	sudo yum clean all     && \
	sudo rm -rf /var/cache/yum && \
	sudo postgresql-setup initdb && \
	sudo systemctl start postgresql  && \
	sudo systemctl enable postgresql  && \
	sudo passwd postgres && \
	su - postgres && \
	su --shell /bin/bash postgres && \
	su - postgres && \
	psql -d template1 -c "ALTER USER postgres WITH PASSWORD 'postgres';"
SCRIPT

$script_install_protheus = <<-SCRIPT

	# criando a estrutura das pastas para instalação do protheus
	# este script busca dentro do arte da engenharia, todos os componentes atualizados para provisionar a base.
	# uma vez provisionado, o ambiente sempre trabalhará com o ultimo rpo (d-1) disponibilizado, caso queira manter o teste
	sudo echo 'criando estrutura de pastas'
	sudo mkdir -p /protheus && \
	sudo mkdir -p /protheus/apo && \
	sudo mkdir -p /protheus/bin && \
	sudo mkdir -p /protheus/bin/appserver && \
	sudo mkdir -p /protheus/protheus_data && \
	sudo mkdir -p /protheus/protheus_data/data && \
	sudo mkdir -p /protheus/protheus_data/systemload && \
	sudo mkdir -p /protheus/protheus_data/systemload/updmenu && \
	sudo mkdir -p /protheus/protheus_data/web && \

	# db --> dicionario no banco
	# ds --> dicionario no system
	# configurar o ini do protheus (manifests/protheus_appserver.ini) todos os ambientes para direcionar para estas pastas.
	# no caso do mssqlserver, deve-se ter o mesmo instalado em sua maquina, ou direcionado para um odbc instalado na rede
	# IMPORTANTE: Todas as vezes que provisionar a maquina, os dados de SX serão apagados e deverão ser recriados novamente, desta forma, recomendamos sempre utilizar o ambiente db
	sudo mkdir -p /protheus/protheus_data/system && \	
	sudo mkdir -p /protheus/protheus_data/system/modelo && \	
	sudo mkdir -p /protheus/protheus_data/system/mssqlserver_db && \	
	sudo mkdir -p /protheus/protheus_data/system/mssqlserver_ds && \	
	sudo mkdir -p /protheus/protheus_data/system/oracle_db && \	
	sudo mkdir -p /protheus/protheus_data/system/oracle_ds && \	
	sudo mkdir -p /protheus/protheus_data/system/postgresql_db && \	
	sudo mkdir -p /protheus/protheus_data/system/postgresql_ds && \	
	sudo mkdir -p /protheus/protheus_data/system/db2_db && \	
	sudo mkdir -p /protheus/protheus_data/system/db2_ds && \	
	
	########## ARTEFATOS DO BINARIO ##########
	# para realizar o download dos artefatos, utilizamos os nomes comuns disponibilizados pela engenharia, desta forma, a tendencia de manutenção no mesmo fica reduzida.
	sudo echo 'realizando download dos arquivos de instalação'
	cd /protheus/bin/appserver && \
	sudo wget https://arte.engpro.totvs.com.br/tec/appserver/lobo_guara/linux/64/published/appserver.tar.gz && \
	sudo tar -xvzf appserver.tar.gz && \
	sudo rm -f *.tar.gz && \
	sudo chmod 777 *.so && \

	sudo wget https://arte.engpro.totvs.com.br/tec/smartclientwebapp/lobo_guara/linux/64/published/webapp.tar.gz && \
	sudo tar -xvzf webapp.tar.gz && \
	sudo rm -f *.tar.gz && \

	########## RPO ##########
	# Faremos um scrit para download automatico do RPO apos o provisionamento das maquinas
	# para a primeira instalação, sempre copiamos o rpo atual.
	cd /protheus/apo && \
	sudo wget https://arte.engpro.totvs.com.br/protheus/padrao/published/repositorio/lobo_guara/tttp120.rpo && \

	
	########## ARTEFATOS DO SYSTEM ##########
	cd /protheus/protheus_data/system/modelo && \
	sudo wget https://arte.engpro.totvs.com.br/protheus/padrao/published/dicionario/arquivos_de_configuracao/19-02-14-ARQUIVOS_CONFIGURACAO_FISCAL_12_1_23.ZIP && \
	sudo wget https://arte.engpro.totvs.com.br/protheus/padrao/published/dicionario/arquivos_de_configuracao/19-02-15-ARQUIVOS_PORTAL_E_WIZARD_SIGAPLS_12.1.23.ZIP && \
	sudo wget https://arte.engpro.totvs.com.br/protheus/padrao/published/dicionario/stored_procedures/19-02-15-STORED_PROCEDURES_TODAS_V12.1.23.ZIP && \
	sudo wget https://arte.engpro.totvs.com.br/protheus/padrao/published/dicionario/menus/completo/19-02-15-BRA-MENUS_12_1_23.ZIP  && \
	sudo unzip -o 19-02-14-ARQUIVOS_CONFIGURACAO_FISCAL_12_1_23.ZIP && \
	sudo unzip -o 19-02-15-ARQUIVOS_PORTAL_E_WIZARD_SIGAPLS_12.1.23.ZIP && \
	sudo unzip -o 19-02-15-STORED_PROCEDURES_TODAS_V12.1.23.ZIP && \
	sudo unzip -o 19-02-15-BRA-MENUS_12_1_23.ZIP && \
	sudo unzip -o 'arquivos CSV.zip' && \
	sudo unzip -o 'arquivos JS.zip' && \
	sudo rm -f *12_1_23.ZIP && \

	sudo cp -f -r * ../mssqlserver_db && \
	sudo cp -f -r * ../oracle_db && \
	sudo cp -f -r * ../postgresql_db && \
	sudo cp -f -r * ../db2_db && \
	sudo cp -f -r * ../mssqlserver_ds && \
	sudo cp -f -r * ../oracle_ds && \
	sudo cp -f -r * ../postgresql_ds && \
	sudo cp -f -r * ../db2_ds && \

	########## ARTEFATOS DO SYSTEMLOAD ##########
	cd /protheus/protheus_data/systemload && \
    sudo wget https://arte.engpro.totvs.com.br/protheus/padrao/published/dicionario/dicionario_de_dados/completo/19-02-15-BRA-DICIONARIOS_COMPL_12_1_23.ZIP	 && \
    sudo wget https://arte.engpro.totvs.com.br/protheus/padrao/published/dicionario/dicionario_de_dados/diferencial/19-02-15-BRA-DICIONARIOS_DIF_12_1_23.ZIP && \
	sudo wget https://arte.engpro.totvs.com.br/protheus/padrao/published/dicionario/help_de_campo/completo/19-02-14-BRA-HELPS_COMPL_12_1_23.ZIP && \
	sudo unzip -o 19-02-15-BRA-DICIONARIOS_COMPL_12_1_23.ZIP && \
	sudo unzip -o 19-02-15-BRA-DICIONARIOS_DIF_12_1_23.ZIP && \
	sudo unzip -o 19-02-14-BRA-HELPS_COMPL_12_1_23.ZIP && \
	sudo rm -f *12_1_23.ZIP && \
	cd /protheus/protheus_data/systemload/bra && \
	sudo cp * .. && \
	cd .. && \
	sudo rm bra/* -f  && \
	sudo rmdir bra &&\

	cd /protheus/protheus_data/systemload/updmenu && \
	sudo wget https://arte.engpro.totvs.com.br/protheus/padrao/published/dicionario/menus/completo/19-02-15-BRA-MENUS_12_1_23.ZIP  && \
	sudo unzip -o 19-02-15-BRA-MENUS_12_1_23.ZIP && \
	sudo rm -f *12_1_23.ZIP && \

	cd /protheus/protheus_data/web && \
	sudo wget https://arte.engpro.totvs.com.br/protheus/padrao/published/dicionario/web-files/19-02-15-WEB-FILES-P12.1.23.ZIP && \
	sudo unzip -o 19-02-15-WEB-FILES-P12.1.23.ZIP && \
	sudo rm -f *12.1.23.ZIP
SCRIPT

$script_install_lockserver = <<-SCRIPT

	sudo echo 'criando estrutura de pastas'
	sudo mkdir -p /protheus && \
	sudo mkdir -p /protheus/apo && \
	sudo mkdir -p /protheus/bin && \
	sudo mkdir -p /protheus/bin/appserver && \

	sudo echo 'realizando download dos arquivos de instalação'

	cd /protheus/bin/appserver && \
	sudo wget https://arte.engpro.totvs.com.br/tec/appserver/lobo_guara/linux/64/published/appserver.tar.gz && \
	sudo tar -xvzf appserver.tar.gz && \
	sudo rm -f *.tar.gz && \
	sudo chmod 777 *.so
SCRIPT

$script_lockserver_start = <<-SCRIPT
	sudo cp /synced_folder/manifests/init-lockserver.sh /usr/local/bin/init-lockserver.sh && \
	sudo sed -i -e 's/\r$//' /usr/local/bin/init-lockserver.sh && \
	sudo chmod +x /usr/local/bin/* /usr/bin/* && \
	sudo echo export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/protheus/bin/appserver:/usr/local/bin &&\
	sudo echo reboot
SCRIPT

$script_protheus_start = <<-SCRIPT
	sudo cp /synced_folder/manifests/init-protheus.sh /usr/local/bin/init-protheus.sh && \
	sudo sed -i -e 's/\r$//' /usr/local/bin/init-protheus.sh && \
	sudo chmod +x /usr/local/bin/* /usr/bin/* && \
	sudo echo export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/protheus/bin/appserver:/usr/local/bin &&\
	sudo echo reboot
SCRIPT

$script_protheus_rest_start = <<-SCRIPT
	sudo cp /synced_folder/manifests/init-protheus-rest.sh /usr/local/bin/init-protheus-rest.sh && \
	sudo sed -i -e 's/\r$//' /usr/local/bin/init-protheus-rest.sh && \
	sudo chmod +x /usr/local/bin/* /usr/bin/* && \
	sudo echo export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/protheus/bin/appserver:/usr/local/bin &&\
	sudo echo reboot
SCRIPT

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "bento/centos-7.2"
  # config.vbguest.auto_update = false
  config.ssh.insert_key = false
  # config.ssh.private_key_path = ["~/.ssh/id_rsa", "~/.vagrant.d/insecure_private_key"]
  # config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/authorized_keys"
  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"

  # habilita a interface grafica no virtualbox
  # config.vm.provider "virtualbox" do |vb|
  #    vb.gui = true
  # end
  
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "./configs", "/synced_folder"

  config.vm.provision "shell", inline: "cat /synced_folder/autorization.pub >> .ssh/authorized_keys"
  config.vm.provision "shell", inline: $script_init

  # workaround the vagrant 1.8.5 bug
  config.ssh.insert_key = false
 
  # maquina postgres	  
  config.vm.define "postgres" do |postgres|
	# postgres.vm.network "public_network", type: "dhcp"
	postgres.vm.hostname = "dbaccess-svc"
    postgres.vm.network :private_network, ip: "192.168.56.100"
	postgres.vm.network "forwarded_port", guest: 22, host: 2300

	postgres.vm.provider "virtualbox" do |v_postgres|
		# change memory size
		v_postgres.memory = 2048
		v_postgres.cpus = 2
		v_postgres.name = "postgres-svc"
		v_postgres.customize ["modifyvm", :id, "--cableconnected1", "on"]
		v_postgres.customize ["modifyvm", :id, "--ioapic", "on"]
		v_postgres.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
		
		# postgres port forwarding
		v_postgres.vm.network "forwarded_port", guest: 1521, host: 1521
	end
	
    postgres.vm.provision "shell", inline: $script_postgres
    postgres.vm.provision "shell", inline: "service postgresql restart"
  end
 
  config.vm.define "oracle" do |oracle|
    # oracle.vm.network "public_network", ip: "192.168.1.200"
	# oracle.vm.network "public_network", type: "dhcp"
	oracle.vm.hostname = "dbaccess-svc"
    oracle.vm.network :private_network, ip: "192.168.56.100"
	oracle.vm.network "forwarded_port", guest: 22, host: 2300

	oracle.vm.provider "virtualbox" do |v_oracle|
		# change memory size
		v_oracle.memory = 2048
		v_oracle.cpus = 2
		v_oracle.name = "oracle12c-svc"
		v_oracle.customize ["modifyvm", :id, "--cableconnected1", "on"]
		v_oracle.customize ["modifyvm", :id, "--ioapic", "on"]
		v_oracle.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
		
		# Oracle port forwarding
		v_oracle.vm.network "forwarded_port", guest: 1521, host: 1521

		# Provision everything on the first run
		v_oracle.vm.provision "shell", path: "/synced_folder/scripts/oracle_install.sh"
		v_oracle.vm.synced_folder "./oradata", "/synced_folder/oradata", owner: "oracle", group: "oinstall"
	end
  end

  config.vm.define "lockserver" do |lockserver|
    lockserver.vm.provider "virtualbox" do |v_lockserver|
      v_lockserver.memory = 1024
      v_lockserver.cpus = 1
      v_lockserver.name = "protheus-lockserver-svc"
      # v_lockserver.customize ["modifyvm", :id, "--nictype1", "virtio"] # makes the internet speed faster in Win10 host
    end

    lockserver.vm.network :private_network, ip: "192.168.56.10"
	lockserver.vm.network "forwarded_port", guest: 22, host: 2210
	lockserver.vm.hostname = "protheus-lockserver-svc"
    lockserver.vm.provision "shell", inline: $script_install_lockserver
	lockserver.vm.provision "shell", inline: $script_lockserver_start
  end  
 
  config.vm.define "protheus" do |protheus|
    protheus.vm.provider "virtualbox" do |v_protheus|
      v_protheus.memory = 768
      v_protheus.cpus = 1
      v_protheus.name = "protheus-svc"
	  v_protheus.customize ["modifyvm", :id, "--cableconnected1", "on"]
	  # v_protheus.customize ["modifyvm", :id, "--ioapic", "on"]
	  v_protheus.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
	  # v_protheus.customize ["modifyvm", :id, "--nictype1", "virtio"] # makes the internet speed faster in Win10 host
      # v_protheus.customize ["modifyvm", :id, "--nictype2", "virtio"]
	  v_protheus.customize ["modifyvm", :id, "--audio", "none"]
	end

	protheus.vm.hostname = "protheus-svc"
	protheus.vm.network "private_network", ip: "192.168.56.20"
    protheus.vm.provision "shell", inline: $script_install_protheus
	protheus.vm.provision "shell", inline: $script_protheus_start
  end

  config.vm.define "protheus_rest" do |protheus_rest|
	protheus_rest.vm.network :private_network, ip: "192.168.56.30"
	protheus_rest.vm.network "forwarded_port", guest: 22, host: 2230
	protheus_rest.vm.hostname = "protheus-rest-svc"

    protheus_rest.vm.provision "shell", inline: $script_install_protheus
	protheus_rest.vm.provision "shell", inline: $script_protheus_rest_start
  end
end

