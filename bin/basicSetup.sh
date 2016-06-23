#!/bin/bash

export INSTALL_DIR=${INSTALL_DIR:-$HOME/usr/local}


if grep "Added for Caffe" ~/.bashrc &> /dev/null ||  [ -d $INSTALL_DIR/stow/palmetto-scripts ]; then
    echo "Old version of palmetto scripts detected."
    echo "Please clean up your home directory before continuing."
    echo "Specifically, try removing the lines after \"\#Added for Caffe\" in ~/.bashrc,"
    echo "and deleting the directories: ~/usr ~/perl5 ~/.cpan ~/.cpanm ~/.local"
    exit 1
fi
    

mkdir -p $INSTALL_DIR/stow/
cd $INSTALL_DIR/stow/
git clone https://github.com/dougnd/palmetto-scripts.git
cd palmetto-scripts
git checkout v2
cd ..


printf "#Added for Caffe\n\
export INSTALL_DIR=$INSTALL_DIR\n\
source $INSTALL_DIR/stow/palmetto-scripts/env_vars.sh\n\
" >> ~/.bashrc

echo "Starting a job to install some initial software..."
JOB_ID=$(qsub  $INSTALL_DIR/stow/palmetto-scripts/pbs/setupPrereqs.pbs)
echo "Waiting for it to finish... (this may take quite some time)"
while [ -n "$(qstat | grep $JOB_ID)" ]; do
    sleep 20
done

echo "done."

echo "Note: The new .bashrc has not taken effect yet. Either logout and in or source it."


