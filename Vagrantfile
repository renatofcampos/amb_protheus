# Vagrantfile API. Não alterar este arquivo.
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos/7"
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "./rootfs", "/rootfs"
  config.vm.synced_folder "./protheus", "/protheus_sync"

  # workaround the vagrant 1.8.5 bug
  # config.ssh.insert_key = false
 
  # maquina postgres	  
  config.vm.define "postgres" do |postgres|
	postgres.vm.hostname = "postgres-svc"
    postgres.vm.network :private_network, ip: "192.168.56.100", netmask: "255.255.255.0", gw: "192.168.56.1"
	postgres.vm.network :forwarded_port, guest: 5432, host: 5432
	postgres.vm.network :forwarded_port, guest: 7890, host: 7890
	
	postgres.vm.provider "virtualbox" do |v_postgres|
		v_postgres.memory = 2048
		v_postgres.cpus = 2
		v_postgres.name = "postgres-svc"
		v_postgres.customize ["modifyvm", :id, "--cableconnected1", "on"]
		v_postgres.customize ["modifyvm", :id, "--ioapic", "on"]
		v_postgres.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
	end
   
	postgres.vm.provision "shell", path: "./rootfs/bashs/postgres_install.sh"
	postgres.vm.provision "shell", path: "./rootfs/bashs/dbaccess_install.sh"

	# apos iniciar o servidor, subir o dbaccess
	postgres.trigger.after :up do |trigger|
      		trigger.warn = "Iniciando Banco de dados"
      		trigger.run_remote = {inline: "sudo systemctl start init-dbaccess.service"}
	end
      		#trigger.run_remote = {inline: "sudo setenforce 0"}
	  	#trigger.run_remote = {inline: "ping 192.168.56.20 -c 10"}
    	#end
	
	# antes de destruir a maquina, tirar um backup do banco
	postgres.trigger.before :destroy do |trigger|
      trigger.warn = "Dumping database to /protheus/logs"
      trigger.run_remote = {inline: "pg_dump protheus_db > /protheus_sync/logs/protheus_db.dump"}
      trigger.run_remote = {inline: "pg_dump protheus_system > /protheus_sync/logs/protheus_system.dump"}
    end
  end
 
  config.vm.define "oracle" do |oracle|
	oracle.vm.hostname = "dbaccess-svc"
    oracle.vm.network :private_network, ip: "192.168.56.101", netmask: "255.255.255.0", gw: "192.168.56.1"
	oracle.vm.network "forwarded_port", guest: 22, host: 2300

	oracle.vm.provider "virtualbox" do |v_oracle|
		v_oracle.memory = 2048
		v_oracle.cpus = 2
		v_oracle.name = "oracle12c-svc"
		v_oracle.customize ["modifyvm", :id, "--cableconnected1", "on"]
		v_oracle.customize ["modifyvm", :id, "--ioapic", "on"]
		v_oracle.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
	end

	# Oracle port forwarding
	oracle.vm.network "forwarded_port", guest: 1521, host: 1521

	# Provision everything on the first run
	oracle.vm.provision "shell", path: "./rootfs/bashs/oracle_rootfs.sh"
	oracle.vm.synced_folder "./oradata", "/rootfs/oradata", owner: "oracle", group: "orootfs"

  end

  config.vm.define "lockserver" do |lockserver|
    lockserver.vm.provider "virtualbox" do |v_lockserver|
      v_lockserver.memory = 1024
      v_lockserver.cpus = 1
      v_lockserver.name = "protheus-lockserver-svc"
    end

    lockserver.vm.network :private_network, ip: "192.168.56.10", netmask: "255.255.255.0", gw: "192.168.56.1"
	lockserver.vm.network "forwarded_port", guest: 22, host: 2210
	lockserver.vm.hostname = "protheus-lockserver-svc"
	lockserver.vm.synced_folder "./protheus", "/protheus_sync"
	lockserver.vm.provision "shell", path: "./rootfs/bashs/protheus_minimal_install.sh"
	
	lockserver.trigger.after :up do |t_lockserver|
      t_lockserver.warn = "Iniciando lockserver"
      t_lockserver.run_remote = {inline: "sudo systemctl start init-lockserver.service"}
    end
  end  
 
  config.vm.define "protheus" do |protheus|
    protheus.vm.provider "virtualbox" do |v_protheus|
      v_protheus.memory = 2048
      v_protheus.cpus = 2
      v_protheus.name = "protheus-svc"
	  v_protheus.customize ["modifyvm", :id, "--cableconnected1", "on"]
	  v_protheus.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
	  v_protheus.customize ["modifyvm", :id, "--audio", "none"]
	end

	protheus.vm.hostname = "protheus-svc"
	protheus.vm.network "private_network", ip: "192.168.56.20", netmask: "255.255.255.0", gw: "192.168.56.1"
	protheus.vm.network "forwarded_port", guest: 4903, host: 4903
	
	protheus.vm.provision "shell", path: "./rootfs/bashs/protheus_install.sh"

	protheus.vm.synced_folder "./protheus/protheus_data", "/protheus/protheus_data/pasta_sincronizada"
	protheus.vm.synced_folder "./protheus", "/protheus_sync"

	protheus.trigger.after :up do |t_protheus|
      t_protheus.warn = "Iniciando protheus"
      t_protheus.run_remote = {inline: "sudo systemctl start init-protheus.service"}
    end
  end

  config.vm.define "protheus_rest" do |protheus_rest|
    protheus_rest.vm.provider "virtualbox" do |v_protheus_rest|
      v_protheus_rest.memory = 1024
      v_protheus_rest.cpus = 1
      v_protheus_rest.name = "protheus_rest-svc"
	  v_protheus_rest.customize ["modifyvm", :id, "--cableconnected1", "on"]
	  v_protheus_rest.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
	  v_protheus_rest.customize ["modifyvm", :id, "--audio", "none"]
	end

	protheus_rest.vm.hostname = "protheus_rest-svc"
	protheus_rest.vm.network "private_network", ip: "192.168.56.30", netmask: "255.255.255.0", gw: "192.168.56.1"
	protheus_rest.vm.provision "shell", path: "./rootfs/bashs/protheus_minimal_install.sh"

	protheus_rest.vm.synced_folder "./protheus/protheus_data", "/protheus/protheus_data/pasta_sincronizada"
	protheus_rest.vm.synced_folder "./protheus", "/protheus_sync"

	protheus_rest.trigger.after :up do |t_protheus_rest|
	  t_protheus_rest.warn = "Iniciando protheus"
      t_protheus_rest.run_remote = {inline: "sudo systemctl start init-protheus-rest.service"}
    end
  end
end

