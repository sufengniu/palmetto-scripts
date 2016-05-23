# palmetto-scripts

Some scripts and tools to help me manage my programs on the Palmetto Cluster


# Usage:

## dinstall

```bash
dinstall <name>
```
Installs `<name>` to `$INSTALL_DIR`.  Default `$INSTALL_DIR` is `$HOME/usr/bin`.  You should also set the enviornment variable `$cores` to specify how many cores to use when building.

## getGPUNode, getCPUNode

Scripts to either get a CPU or GPU node. The CPU node is 6 cores, 8GB, 6hrs. The GPU node is 6 cores, 10GB.
```bash
getGPUNode
```
or
```bash
getCPUNode
```

# Fresh install: (not fully tested)

Decide where you want to install things.  I assume `~/usr/local`.
Add info to `.bashrc`:
```bash
module add cuda-toolkit/7.0.28 gcc/4.8.1
export PATH="$HOME/usr/local/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/usr/local/lib${LD_LIBRARY_PATH:+":$LD_LIBRARY_PATH"}"
export LIBRARY_PATH="$HOME/usr/local/lib${LIBRARY_PATH:+":$LIBRARY_PATH"}"
```

Get an interactive job:
```bash
qsub -I
```

We need some perl modules:
```bash
cpan App::cpanminus
source ~/.bashrc # update PATH changes from the previous command 
cpanm Test::Output
```

Get these scripts:
```bash
mkdir -p $HOME/usr/local/stow/; cd $HOME/usr/local/stow/
git clone https://github.com/dougnd/palmetto-scripts.git
```

Install stow, then the palmetto-scripts:
```bash
cd ~/usr/local/stow
palmetto-scripts/bin/dinstall stow
stow palmetto-scripts
```

You are done with that CPU only interactive job:
```bash
exit
```

Get an interactive GPU node and install various libraries using dinstall:
```bash
getGPUNode
dinstall mpfr
dinstall gcc
dinstall cmake
dinstall python27
dinstall numpy
dinstall pip
dinstall ipdb
python -m pip install -U scipy
python -m pip install -U scikit-image
dinstall opencv
dinstall leveldb
dinstall gflags
dinstall protobuf
dinstall glog
dinstall lmdb
dinstall snappy
dinstall boost
dinstall caffe
dinstall gdal
dinstall postgresql
dinstall libpqxx
```


