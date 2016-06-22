#!/bin/bash

export INSTALL_DIR=${INSTALL_DIR:-$HOME/usr/local}

mkdir -p $INSTALL_DIR/stow/
cd $INSTALL_DIR/stow/
git clone https://github.com/dougnd/palmetto-scripts.git

printf "#Added for Caffe\n\
module add cuda-toolkit/7.5.18 gcc/4.8.1\n\
export ACLOCAL_PATH=\"\$HOME/usr/local/share/aclocal\${ACLOCAL_PATH:+\":\$ACLOCAL_PATH\"}\"\n\
export PKG_CONFIG_PATH=\"\$HOME/usr/local/lib/pkgconfig\${PKG_CONFIG_PATH:+\":\$PKG_CONFIG_PATH\"}\"\n\
export PATH=\"\$HOME/usr/local/bin:\$PATH\"\n\
export LD_LIBRARY_PATH=\"\$HOME/usr/local/lib64:\$HOME/usr/local/lib\${LD_LIBRARY_PATH:+\":\$LD_LIBRARY_PATH\"}\"\n\
export LIBRARY_PATH=\"\$HOME/usr/local/lib64:\$HOME/usr/local/lib\${LIBRARY_PATH:+\":\$LIBRARY_PATH\"}\"\n\
export PYTHONPATH=\"\$HOME/usr/local/python:\$HOME/usr/local/lib\${PYTHONPATH:+\":\$PYTHONPATH\"}\"\n\
export CPATH=\"\$HOME/usr/local/include\${CPATH:+\":\$CPATH\"}\"\n\
\n#Needed for Auto-Perl Exec\n\
export PERL_MM_USE_DEFAULT=1" >> ~/.bashrc


SECOND=$(qsub  $INSTALL_DIR/stow/palmetto-scripts/pbs/setupPrereqs.pbs)
#echo $SECOND

THIRD=$(qsub -W depend=afterany:$SECOND $INSTALL_DIR/stow/palmetto-scripts/pbs/installCaffe.pbs)
#echo $THIRD

echo "Jobs submitted! get some coffee! watch a movie!  (or ten)"
