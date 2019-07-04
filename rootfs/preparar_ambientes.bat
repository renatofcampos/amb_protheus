@echo off
cls
:menu
cls
color 00

date /t

echo Computador: %computername%        Usuario: %username%

echo  ============================================
echo    DESENVOLVIDO POR RENATO FERREIRA CAMPOS
echo    renato.campos@totvs.com.br
echo  ============================================
      
echo  Para iniciar a utilização do ambiente, deve-se instalar em sua maquina os seguintes software:
echo  - VirtualBox - https://download.virtualbox.org/virtualbox/6.0.8/VirtualBox-6.0.8-130520-Win.exe
echo  - Vagrant - https://releases.hashicorp.com/vagrant/2.2.4/vagrant_2.2.4_x86_64.msi
echo  - Git - https://github.com/git-for-windows/git/releases/download/v2.22.0.windows.1/Git-2.22.0-64-bit.exe     

set /p opcao=Deseja continuar o processo de configuração dos ambientes? (S para SIM e N para NÃO):
echo ------------------------------
if %opcao% equ S goto opcao1
if %opcao% GEQ N goto opcao2

cls

:opcao1
cls
echo  ============================================
echo    DESENVOLVIDO POR RENATO FERREIRA CAMPOS
echo    renato.campos@totvs.com.br
echo  ============================================
echo  Criando estrutura de pastas
mkdir c:\ambientes
cd c:\ambientes

echo Realizando o download do projeto de ambientes
git clone https://github.com/renatofcampos/amb_protheus

cd c:\ambientes\amb_protheus

copy C:\ambientes\amb_protheus\rootfs\ambiente_protheus.bat %HOMEDRIVE%%HOMEPATH%\desktop\ambiente_protheus.bat

echo Iniciando a instalação dos ambientes na maquina local
vagrant plugin install vagrant-vbguest
vagrant up postgres lockserver protheus
vagrant halt
cls
echo  ============================================
echo    DESENVOLVIDO POR RENATO FERREIRA CAMPOS
echo    renato.campos@totvs.com.br
echo  ============================================
echo    Processo de instalação concluido.
pause
exit