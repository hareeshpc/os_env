######
# Scripts to setup my custom mercury env
######

#!/bin/sh

mkdir -p /var/hareesh

if [ ! -d /var/hareesh/mercury_scripts ]; then
  echo "Directory mercury_scripts does not exist. Cloning..."
  cd /var/hareesh
  git clone https://github.com/hareeshpc/mercury_scripts.git
else
  echo "Directory /var/hareesh/mercury_scripts exists. Updating..."
  cd /var/hareesh/mercury_scripts
  git pull origin master
fi

# Go back to home Directory
cd ~

# Source global definitions
if [ -f ~/.bash_profile ]; then
  cp ~/.bash_profile{,.backup}
  echo "" >>~/.bash_profile
  echo "#`date`: Adding Testing enhancements" >> ~/.bash_profile
  echo "PATH=$PATH:/var/hareesh/mercury_scripts" >> ~/.bash_profile
  echo "export PATH" >> ~/.bash_profile
fi
echo "Exporting path variable to current shell"
export PATH=$PATH:/var/hareesh/mercury_scripts
echo "Path set to:${PATH}"


# Adding aliases
if [ ! -f ~/.bashrc ]; then
  touch ~/.bashrc
else
  cp ~/.bashrc{,.backup}
fi


echo " ">> ~/.bashrc
echo "# `date`: Adding Neutron/OS aliases" >> ~/.bashrc
echo "alias n='neutron'" >> ~/.bashrc
echo "alias nlist='neutron net-list'" >> ~/.bashrc
echo "alias rlist='neutron router-list'" >> ~/.bashrc
echo "alias slist='neutron subnet-list'" >> ~/.bashrc
echo "alias plist='neutron port-list'" >> ~/.bashrc
echo "alias rplist='neutron router-port-list'" >> ~/.bashrc
echo "alias riadd='neutron router-interface-add'" >> ~/.bashrc
echo "alias ridel='neutron router-interface-delete'" >> ~/.bashrc
echo "alias rgset='neutron router-gateway-set'" >> ~/.bashrc
echo "alias rgclear='neutron router-gateway-clear'" >> ~/.bashrc
echo "alias l3r='neutron l3-agent-list-hosting-router'" >> ~/.bashrc
echo "alias flist='neutron floatingip-list'" >> ~/.bashrc
echo "alias fcreate='neutron floatingip-create'" >> ~/.bashrc
echo "alias fass='neutron floatingip-associate'" >> ~/.bashrc
echo "alias fdel='neutron floatingip-delete'" >> ~/.bashrc

source ~/.bashrc
