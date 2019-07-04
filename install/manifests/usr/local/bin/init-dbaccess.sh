#!/bin/bash
set -e

echo atualizando appserver.ini
cp /install/manifests/dbaccess.ini /dbaccess/dbaccess.ini

echo Executing dbaccess

cd /dbaccess
if [ -f ./dbaccess64 ]; then
  ./dbaccess64
else
  ./dbaccess
fi

echo dbaccess broke
