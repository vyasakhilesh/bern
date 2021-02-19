#!/bin/bash

#trap "exit" INT TERM ERR

#trap "kill 0" EXIT

HOMEE='/nfs/home/vyasa/projects/proj_os/repos/bern'

echo '##################################Directroy#############################################################'

pwd

cd $HOMEE/GNormPlusJava
java -Xmx16G -Xms16G -jar GNormPlusServer.jar 18895 >> $HOMEE/logs/nohup_gnormplus.out 2>&1 &

cd $HOMEE/tmVarJava
java -Xmx8G -Xms8G -jar tmVar2Server.jar 18896 >> $HOMEE/logs/nohup_tmvar.out 2>&1 &

cd $HOMEE
sh load_dicts.sh &

echo '######################### CUDA_VISIBLE_DEVICES ##############################'
echo $CUDA_VISIBLE_DEVICES
export CUDA_VISIBLE_DEVICES=0


python3 -u server.py --port 8888 --gnormplus_home $HOMEE/GNormPlusJava --gnormplus_port 18895 --tmvar2_home $HOMEE/tmVarJava --tmvar2_port 18896 >> $HOMEE/logs/nohup_BERN.out 2>&1 &

tail -F $HOMEE/logs/nohup_BERN.out &
