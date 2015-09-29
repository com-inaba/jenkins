#!/bin/bash

## function of return checker.
returnChecker() {
if [[ $1 != 0 ]]; then
vagrant destroy –force
exit 1
fi
}

## Vagrant up phase.
vagrant_plugins=”dotenv vagrant-digitalocean”
for p in $vagrant_plugins; do
vagrant plugin list |grep $p
if [[ $? != 0 ]]; then
vagrant plugin install $p
fi
done
vagrant up –provider=digital_ocean; returnChecker $?
vagrant ssh-config –host=”do-ci.centos” > ssh-config

## Ansible pahse.
ipaddr=`grep “HostName” ./ssh-config |awk ‘{print $2}’`
sed -i “s/x.x.x.x/$ipaddr/” hosts
ansible-playbook –private-key=id_rsa –inventory-file=hosts playbook.yaml; returnChecker $?

### Serverspec phase.
. /etc/bashrc
bundle install –path vendor/bundle; returnChecker $?
bundle exec rake spec; returnChecker $?

## Vagrant destroy phase.
vagrant destroy –force

exit 0
