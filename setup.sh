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
  echo "Directory /var/hareesh/mercury_scripts exists. Doing nothing..."
  #cd /var/hareesh/mercury_scripts
  #git pull origin master
fi


if [ -f ~/.bash_profile ]; then
  cp ~/.bash_profile{,.backup}

  # Add new functions path
  echo "" >> ~/.bash_profile # New line
  echo "# `date`: Adding Testing enhancements" >> ~/.bash_profile
  echo "PATH=$PATH:/var/hareesh/mercury_scripts" >> ~/.bash_profile
  echo "export PATH" >> ~/.bash_profile

  # Source openrc
  cat <<EOF >>~/.bash_profile

  if [ -f /root/openstack-configs/openrc ]; then
    . /root/openstack-configs/openrc
  fi
EOF
fi

echo "Exporting path variable to current shell also"
export PATH=$PATH:/var/hareesh/mercury_scripts
echo "Path set to:${PATH}"


# Adding aliases

echo "Adding OS aliases...."
cd /var/hareesh
echo "Path is:$(pwd)"
curl -O https://raw.githubusercontent.com/hareeshpc/os_env/master/.bash_aliases

if [ -f ~/.bash_aliases ]; then
  echo " Found exisiting .bash_aliases. Appending...."
  cat .bash_aliases >> ~/.bash_aliases
else
  echo "Creating .bash_aliases"
  cp .bash_aliases ~
fi

if [ -f ~/.bash_profile ]; then
    # Add bash aliases
    echo " ">> ~/.bash_profile
    echo "# `date`: Adding Neutron/OS aliases" >> ~/.bash_profile
    cat <<EOF >>~/.bash_profile
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi
EOF
fi

echo "Relogin for aliases to take effect or simply source ~/.bash_aliases"
