#!/usr/bin/env bash

echo "Setting up vhost alias!"

# TODO: Add vhost.sh to a Monkee-Boy repo vs Vaprobash this uses puphpet now.
curl --silent -L https://raw.githubusercontent.com/Monkee-Boy/vagrant/master/vhost.sh > vhost
sudo chmod guo+x vhost
sudo mv vhost /usr/local/bin
