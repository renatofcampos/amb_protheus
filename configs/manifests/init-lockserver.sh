#!/bin/bash
set -e

#/usr/local/bin/wait-for-it.sh protheus-dbaccess-svc:7890 --timeout=0
#/usr/local/bin/wait-for-http-200.sh http://protheus-license-hc-svc:8100/hclicenseserver.apl
#/usr/local/bin/wait-for-it.sh protheus-lockserver-svc:7786 --timeout=0

echo atualizando appserver.ini
cp /synced_folder/manifests/lockserver_appserver.ini /protheus/bin/appserver/appserver.ini

echo Executing appserver
cd /protheus/bin/appserver/

./appsrvlinux

echo Appserver broke
