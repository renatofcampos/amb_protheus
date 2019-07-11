#!/bin/bash
set -e

ping 192.168.56.20 -c 10

echo "Iniciando Banco de dados"

setenforce 0

echo atualizando appserver.ini
cp /rootfs/machine/dbaccess.ini /dbaccess/dbaccess.ini

echo "Executing dbaccess"

cd /dbaccess
if [ -f ./dbaccess64 ]; then
  ./dbaccess64
else
  ./dbaccess
fi

echo dbaccess broke
