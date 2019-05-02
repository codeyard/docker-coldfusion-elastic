#!/bin/sh

cd $(dirname "$0")
cd build/install

if [ ! -f "ColdFusion_10_WWEJ_linux64.bin" ]
then
	wget -q https://s3-eu-west-1.amazonaws.com/igloo-devops/coldfusion10-install/ColdFusion_10_WWEJ_linux64.bin
	chmod 755 ColdFusion_10_WWEJ_linux64.bin
fi

if [ ! -f "hotfix_023.jar" ]
then
	wget -q https://cfdownload.adobe.com/pub/adobe/coldfusion/hotfix_023.jar
	chmod 755 hotfix_023.jar
fi

if [ ! -f "cf10_mdt_updt.jar" ]
then
	wget -q https://s3-eu-west-1.amazonaws.com/igloo-devops/coldfusion10-install/cf10_mdt_updt.jar
	chmod 755 cf10_mdt_updt.jar
fi
