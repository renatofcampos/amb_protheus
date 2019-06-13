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
echo        MENU INICIANDO AMBIENTES
echo  ============================================
echo  * 1. Ambiente Protheus + SQL Server        * 
echo  * 2. Ambiente Protheus + PostgreSQL        * 
echo  * 3. Ambiente Protheus + Oracle            *
echo  * 4. Ambiente Protheus + DB2               *
echo  * 5. Apagar todos os ambientes             *
echo  * 6. Sair                                  * 
echo  ============================================

set /p opcao= Escolha uma opcao: 
echo ------------------------------
if %opcao% equ 1 goto opcao1
if %opcao% equ 2 goto opcao2
if %opcao% equ 3 goto opcao3
if %opcao% equ 4 goto opcao4
if %opcao% equ 5 goto opcao5
if %opcao% equ 6 goto opcao6
if %opcao% GEQ 7 goto opcao7

cls

:opcao1
cls
echo =====================================
echo *   Ambiente Protheus + SQL Server  *
echo =====================================
cd c:\vagrant\amb_protheus\
vagrant up lockserver protheus
cls
echo ===========================================
echo *   Ambiente iniciado no IP 192.168.56.20 *
echo ===========================================
pause
goto menu_stop


:opcao2
cls
echo =====================================
echo *   Ambiente Protheus + PostgreSQL  *
echo =====================================
cd c:\vagrant\amb_protheus\
vagrant up lockserver protheus postgresql
cls
echo ===========================================
echo *   Ambiente iniciado no IP 192.168.56.20 *
echo ===========================================
pause
goto menu_stop

:opcao3
cls
echo ==================================
echo *  em desenvolvimento            *
echo ==================================
pause
goto menu_stop

:opcao4
cls
echo ==================================
echo *  em desenvolvimento            *
echo ==================================
pause
goto menu_stop

:opcao5
cls
echo ==================================
echo *    apagando todos ambientes    *
echo ==================================
cd c:\vagrant\amb_protheus\
vagrant destroy
pause
goto opcao6

:opcao6
cls
exit

:opcao7
echo ==============================================
echo * Opcao Invalida! Escolha outra opcao do menu *
echo ==============================================
pause
goto menu

:menu_stop
cls
color 40

date /t

echo Computador: %computername%        Usuario: %username%
echo  ============================================
echo    DESENVOLVIDO POR RENATO FERREIRA CAMPOS
echo    renato.campos@totvs.com.br
echo  ============================================
echo               MENU AMBIENTES
echo  ============================================
echo  * 1. PARAR AMBIENTE                        * 
echo  * 2. ATUALIZAR RPO                         * 
echo  ============================================

set /p opcao= Escolha uma opcao: 
echo ------------------------------
if %opcao% equ 1 goto opcaod1
if %opcao% equ 2 goto opcaod2
if %opcao% GEQ 3 goto opcaod3


:opcaod1
cls
echo =====================================
echo *         PARANDO AMBIENTE          *
echo =====================================
cd c:\vagrant\amb_protheus\
vagrant halt
cls
echo ===========================================
echo *         Ambientes paralizados           *
echo ===========================================
pause
goto menu

:opcaod2
cls
echo ==============================================
echo * Opcao Invalida! Escolha outra opcao do menu *
echo ==============================================
pause
goto menu_stop

:opcaod3
cls
echo ==============================================
echo * Opcao Invalida! Escolha outra opcao do menu *
echo ==============================================
pause
goto menu_stop
