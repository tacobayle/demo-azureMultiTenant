#!/bin/bash
echo "Copying the github repos"
ansible-playbook git.yml
echo "#####################################"
echo "Apply the configuration"
cd Azure
rm -f hostAzurePublicIp
ansible-playbook azureCreate.yml
sleep 2
ansible-playbook -i hostsAzurePublicIp routingSsh.yml
read -n 1 -s -r -p "Press any key to continue the Avi Config."
cd ../aviBootstrap
ansible-playbook -i hostsAzurePrivate main.yml
cd ../aviAzure
ansible-playbook main.yml
cd ..
rm -fr Azure aviBootstrap aviAzure
