######
# Scripts to setup my custom mercury env
######

#!/bin/sh

mkdir -p /var/hareesh

git clone https://github.com/hareeshpc/mercury_scripts.git

# Source global definitions
if [ -f ~/.bash_profile ]; then
  cp ~/.bash_profile{,.backup}
  echo "PATH=$PATH:/var/hareesh/mercury_scripts" >> ~/.bash_profile
  echo "export PATH" >> ~/.bash_profile
fi
echo "Exporting path variable"
export PATH=$PATH:/var/hareesh/mercury_scripts
