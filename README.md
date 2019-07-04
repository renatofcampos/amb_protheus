#Este projeto tem a finalidade de efetuar a criação automática de ambientes Linux com Protheus. Até este momento temos disponível a instalação do LOCKSERVER, PROTHEUS (12.1.23) e POSTGRES.

**Sinta-se encorajado a questionar e contribuir com esse material**

#### A ideia do projeto é facilitar a vida do analista de desenvolvimento/suporte no que tange os testes e utilização de um ambiente Protheus instalado dentro do Linux.
Neste projeto, utilizei o conceito de virtualização balanceada, ou seja, virtualização de maquinas Linux cujo irão executar tarefas especificas da arquitetura Protheus. 
A instalação básica deste ambiente sobe com:
 Uma máquina Linux Centos com LockServer Instalado
 Uma máquina Linux Centos com Protheus Instalado
 Uma máquina Linux Centos com Postgres + DbAccess Instalado
Todas estas máquinas se comunicam via rede (TCP) privada, cujo somente a máquina HOST (a sua máquina) consegue enxergar. Este modelo foi escolhido devido as limitações da REDE x PESSOAS disponíveis para utilização do ambiente.
As máquinas seguem o padrão “C” de rede, iniciando com 192.168.56.xxx onde o xxx é o endereço final das máquinas virtualizadas.
*Nas próximas versões, estaremos disponibilizando a máquina em Oracle+Dbaccess*

#### Para iniciarmos o processo de utilização da ferramenta, será necessário a instalação dos seguintes softwares em sua máquina:
- Para iniciar a utilização do projeto, deve-se instalar em sua máquina os seguintes softwares:
  -> VirtualBox - https://download.virtualbox.org/virtualbox/6.0.8/VirtualBox-6.0.8-130520-Win.exe
  -> Vagrant - https://releases.hashicorp.com/vagrant/2.2.4/vagrant_2.2.4_x86_64.msi
  -> Git - https://github.com/git-for-windows/git/releases/download/v2.22.0.windows.1/Git-2.22.0-64-bit.exe
#### Se você estiver usando uma máquina ```Windows```, sugiro que instale algum software que dê suporte a comando UNIX como sugiro o [cmder] ou [gitbash]. Este passo não é necessário, porém, facilitará bastante o entendimento de um bash Linux.
#### Se estiver usando uma máquina ```BASE UNIX```, realizar a instalação dos RPMs conforme a sua distribuição.
*Referencias estão citadas no rodapé do mesmo. *


Com os três softwares instalados em sua máquina, realize o download do arquivo: https://github.com/renatofcampos/amb_protheus/blob/master/preparar_ambientes.bat. e copie na sua área de trabalho
Após o download, realize os seguintes passos:
1. Clique duas vezes no arquivo preparar_ambiente.bat
2. Será aberta uma nova janela, indicando a necessidade da instalação dos três softwares supracitados. 
	Caso já tenha efetuado a instalação, basta digitar a letra S (em maiúsculo) para iniciar a instalação dos ambientes em sua máquina. 
Caso não tenha, volte e instale, pois sem eles não é possível a instalação dos ambientes.
3. Após concluído o processo de instalação, será disponibilizado em sua área de trabalho um novo ícone com o nome: ambiente_protheus.bat. 
*Caso não seja criado, entre na pasta: C:\ambientes\amb_protheus\configs\ e copie o arquivo ambiente_protheus.bat para a área de trabalho.*
	Este é o executável que irá subir os ambientes em sua máquina (HOST).
4. Ao executar o atalho, será exibido uma nova tela indicando qual o ambiente que deseja executar, basta escolher o ambiente e iniciar os testes do mesmo.
5. Após a subida do ambiente, a tela ficará vermelha, indicando que o ambiente está no ar, caso queira derruba-lo, basta escolher a opção parar ambiente.
6. Caso deseje excluir todos os ambientes, no menu principal há esta opção, porém, utilize somente se houver mudança de versão no projeto. (Estarei avisando via github). 
	Caso escolha a exclusão dos ambientes, automaticamente será gerado um DUMP do banco de dados (no caso do POSTGRES e ORACLE). Estes poderão ser utilizados no futuro para a nova subida do ambiente ou cópia para outra máquina (HOST).
	*Estou implementando o restore automático na subida do ambiente, caso exista o DUMP, por enquanto este deve ser efetuado manualmente*
#### Configurações
Os ambientes montados utilizam os últimos artefatos disponibilizados pela engenharia Protheus e/ou homologados pela TOTVS.
O Protheus instalado é o LOBO GUARÁ, versão 12.1.23 com o RPO D-1 disponibilizado no momento do provisionamento do ambiente. Todos os artefatos são encontrados no arte.totvs.com.br
O Dbaccess é o 64bits, último homologado, também segue a regra do Protheus, cujo a data é a ultima disponibilizada no momento do provisionamento.
*Ainda não está desenvolvido o auto update e/ou o update via linha de comando dos artefatos do binário, estou trabalhando nisto. *
O PostgreSQL instalado é a versão 10 e o PgAdmin 4, ambos free. 
*Oracle em implementação*
Caso deseje fazer alguma alteração nos INIs padrão do Protheus, entre na pasta de instalação do ambiente e localize a pasta PROTHEUS_INI
*Dica: Caso deseja utilizar um ambiente Protheus Linux com o SQLServer, basta configurar o ini do Protheus para enxergar a sua maquina onde o DbAccess Windows está instalado* 
Para atualização de um RPO, basta parar o ambiente e copiar o RPO desejado dentro da pasta APO que fica dentro da pasta de instalação dos ambientes. (Será liberado na versão 2.0 do projeto)
```NÃO ALTERAR AS DEMAIS PASTAS DE INSTALAÇÃO, POIS PODERA PARAR TODO O AMBIENTE VIRTUAL```
Caso deseje copiar algum arquivo para dentro da pasta do protheus_data, basta copiá-lo dentro da pasta_sincronizada, disponibilizada dentro da pasta de instalação do ambiente.

#### Dúvidas frequentes
Quanto tempo demora o primeiro provisionamento?
O processo de provisionamento poderá demorar cerca de 10 minutos, pois todos os artefatos utilizados no processo, encontram-se em hosts da internet, além disto, temos os artefatos do Protheus cujo encontram-se dentro do arte.totvs.com.br 
	Uma vez provisionado, a subida da máquina deve demorar 2 minutos em média. 

Posso copiar uma tabela do cliente para dentro da máquina virtual?
	Sim, está disponível dentro da pasta de instalação uma pasta chamada pasta_sincronizada, esta pasta é um “atalho” dentro de todos os protheus_data dos ambientes.

Consigo apontar um outro banco de dados para ser utilizado dentro do ambiente Linux?
	Sim, basta configurar os arquivos ini do Protheus que se encontram na pasta de instalação/PROTHEUS_INI, antes de subir o ambiente.

Consigo acessar o ambiente Protheus Linux instalado em minha máquina?
	Sim, porém recomendo que tenha conhecimento em bash ou linha de comando para fazer esta operação. Isto se dá, pois nenhum dos ambientes possuem interface gráfica.
	Para acessar o ambiente, acesse o CMD ou GITBASH e digite:
Cd /ambientes/amb_protheus (o / depende do seu SO ou do bash que está utilizando)
Uma vez posicionado na pasta, basta digitar:
```vagrant ssh protheus``` ou ```vagrant ssh protheus_rest```
Com isto, terá acesso as maquinas do Protheus ou rest. A partir daqui, basta ter conhecimento dos comandos Linux para navegar entre os diretórios.
O Protheus está instalado em: /protheus

Qual a tecnologia está sendo utilizado para montagem dos ambientes?
	Estamos utilizando a tecnologia Vagrant com Virtual Box.

1. [Vagrant, o que é?](#1---vagrant-o-que-é)
1. [Utilizando o ambiente](#2---utilizando-o-ambiente)
1. [Referencias](#referencias)

## 1 - Vagrant, o que é?
>Vagrant é uma ferramenta para construir e compartilhar ambientes de desenvolvimento. Com um fluxo de trabalho simples e com foco na automação, o Vagrant reduz o tempo de configuração de seu ambiente de desenvolvimento.

O Vagrant é um gerenciador de VMs (máquinas virtuais). Através dele é possível definir o ambiente de desenvolvimento onde seu projeto irá rodar. Com suporte para Mac OSX, Linux e Windows, consegue atender boa parte dos desenvolvedores. Ele utiliza providers, boxes e se necessário provisioners.

#### 1.2 - Como funciona?
Quando executamos o comando para o Vagrant subir uma VM, ele lê o arquivo ```Vagrantfile```. Nele estão todas as configurações e definições da VM em questão. O Vagrant inicia uma box no provider, definida no arquivo de configuração. Caso existam mais instruções expressas através de provisioners, ele as executa antes de deixar a máquina disponível.

#### 1.3 - Comandos básicos:

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
