#!/bin/bash
set -e

echo atualizando appserver.ini
cp /protheus_sync/appserver/protheus_rest_appserver.ini /protheus/bin/appserver/appserver.ini

echo Executing appserver
cd /protheus/bin/appserver/

./appsrvlinux

echo Appserver broke
