#Este projeto tem a finalidade de efetuar a criação automática de ambientes linux com protheus

**Sinta-se encorajado a questionar e contribuir com esse material**

#### Se você estiver usando o ```Windows``` instale algum software que dê suporte a comando UNIX, sugiro o [cmder] ou [gitbash]

*Referencias estão citadas no rodapé do mesmo.*

#### Nesse material estarei demonstrando como instalar e utilizar o ambiente protheus em linux. Para isto, estamos utilizando a versão CENTOS 7.2 (distr linux baseado no redhat)

#### INICIANDO
- Para iniciar a utilização do projeto, deve-se instalar em sua maquina os seguintes software:
VirtualBox - https://download.virtualbox.org/virtualbox/6.0.8/VirtualBox-6.0.8-130520-Win.exe
Vagrant - https://releases.hashicorp.com/vagrant/2.2.4/vagrant_2.2.4_x86_64.msi
Git - https://github.com/git-for-windows/git/releases/download/v2.22.0.windows.1/Git-2.22.0-64-bit.exe

#### Versão Vagrant 1.7.4

## Tabela de Conteúdo

1. [Vagrant, o que é?](#1---vagrant-o-que-é)
1. [Utilizando o ambiente](#2---utilizando-o-ambiente)
1. [Referencias](#referencias)

## Instalação

Para um setup básico, você precisará instalar o Vagrant e o VirtualBox em sua máquina. A melhor maneira de fazer isso é buscar os pacotes mais atualizados diretamente na [página do Vagrant] e na [página do VirtualBox]. Ambos estão disponíveis para os principais sistemas operacionais. 

## 1 - Vagrant, o que é?

>Vagrant é uma ferramenta para construir e compartilhar ambientes de desenvolvimento. Com um fluxo de trabalho simples e com foco na automação, o Vagrant reduz o tempo de configuração de seu ambiente de desenvolvimento.

O Vagrant é um gerenciador de VMs (máquinas virtuais). Através dele é possível definir o ambiente de desenvolvimento onde seu projeto irá rodar. Com suporte para Mac OSX, Linux e Windows, consegue atender boa parte dos desenvolvedores. Ele utiliza providers, boxes e se necessário provisioners.

#### 1.2 - Como funciona?
Quando executamos o comando para o Vagrant subir uma VM, ele lê o arquivo ```Vagrantfile```. Nele estão todas as configurações e definições da VM em questão. O Vagrant inicia uma box no provider, definida no arquivo de configuração. Caso existam mais instruções expressas através de provisioners, ele as executa antes de deixar a máquina disponível.


## 2 - Utilizando o ambiente

#### 2.1 - Instalando ambientes em sua maquina
1. Após instalado os arquivos necessários, realize o download do arquivo https://github.com/renatofcampos/amb_protheus/blob/master/preparar_ambientes.bat 
2. Execute o install.bat em modo de administrador
	Este instalador irá realizar a criação das pastas dentro do seu disco C: com o nome amb_protheus e irá realizar o download de todos os componentes necessários para utilização dos ambientes.
3. Após concluido o processo de instalação, verifique em sua área de trabalho se foi criado o atalho ambiente_protheus.bat. Se não foi criado, entre na pasta: C:\ambientes\amb_protheus\configs\ e copie o arquivo ambiente_protheus.bat para a area de trabalho.
	Este arquivo ao ser executado irá exibir um menu de inicialização dos ambientes, neste momento somente temos disponiveis o ambiente Linux com SQLSERVER (deve-se apontar o ini para o seu dbaccess local) Até este momento, temos disponivel o ambiente Protheus com MSSQLSERVER e Protheus com PostgreSQL. Basta clicar no arquivo "start_nome do ambiente.bat" e aguardar o provisionamento do ambiente localmente.
	O processo de provisionamento poderá demorar cerca de 10 minutos, pois todos os artefatos do protheus e do banco são realizados download do arte.totvs.com.br e das bibliotecas necessárias para o protheus executar.
	Uma vez provisionado, a subida da maquina deve demorar 2 minutos em média. 
	Para parar o ambiente, basta escolher a opção para ambiente.
	Para excluir todo ambiente para nova criação, basta executar a opção de apagar ambiente.
4. Dentro da pasta C:\ambientes\amb_protheus tem uma pasta chamada pasta_sincronizada. Esta pasta te da acesso a uma pasta dentro do protheus_data do protheus. Caso queira copiar algum arquivo para dentro do ambiente e/ou extrair alguma informação, utilize esta pasta para realizar o processo desejado.
5. Neste projeto não damos acesso as pastas de instalação do protheus e/ou do linux que ele está instalado, pois a ideia é montarmos um ambiente mais proximo de nossos clientes em sua maquina. Caso tenha conhecimento avançado em bash/linux, basta realizar um ssh no IP 127.0.0.1 ou digitar vagrant ssh protheus para ter acesso as pastas do sistema.



#### 2.2 - Comandos básicos:

Comando   | Descrição  | Uso
----------------------------|-------------------------------------------------------| ----------------------------------------------------
vagrant up                  | Inicializa a maquia virtual e executa o provisioner.  |Quando vamos começar a subir nosso ambiente.
vagrant reload              | Reinicia a máquina virtual.                           |Necessário caso haja alteração no vagrantfile.
vagrant provision           | Executa o provisioner.                                |Quando o script de provisionamento for alterado.
vagrant halt                | Desliga a máquina virtual.                            |Quando vamos desligar a maquina virtual.
vagrant destroy             | Destrói a máquina virtual                             |Quando vamos limpar tudo e começar de novo
vagrant ssh                 | Acessa a máquina virtual via ssh                      |Quando queremos executar comandos manuais

# Referencias

- http://www.vagrantup.com
[página do Vagrant]:https://www.vagrantup.com/downloads.html
[página do VirtualBox]:https://www.virtualbox.org/wiki/Downloads
