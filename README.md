# palmetto-scripts

Some scripts and tools to help me manage my programs on the Palmetto Cluster

## Installation:

### Initialization:
do this first to install the palmetto-scripts (takes ~5 minutes to run). You only have to do this once.
```bash
bash <(curl -s https://raw.githubusercontent.com/dougnd/palmetto-scripts/master/bin/basicSetup.sh)
```

### Install tensorflow:
```bash
getGPULikeNode  # get a node for installation purposes
dinstall tensorflow
exit # leave the node
```

### Test tensorflow:
```bash
qsub -I -l select=1:ncpus=1:mem=10gb:ngpus=2:gpu_model=k40,walltime=0:30:00

cd $TMPDIR
wget https://github.com/tensorflow/tensorflow/tarball/master # may have to try this more than once
tar xf master
cd tensorflow-tensorflow-*/tensorflow/models/image/mnist
python convolutional.py

exit # leave the node
```
Note: the following was added to the palmetto MOTD: "Jobs that request gpus but don't use them may be terminated without notice."  Make sure if you are request a gpu, you actually are using it.  You may want to develop on a local machine and deploy to palmetto once you know it works.

### Install caffe:
```bash
getGPULikeNode  # get a node for installation purposes
dinstall caffe_cudnn
exit # leave the node
```

## Usage:

### dinstall
```bash
dinstall [<options>...] <command> [<packages>...]
```
Command can be one of the following:
- `update` - updates dinstall and palmetto-scripts (pulls from github).
- `install` - installs packages and their dependencies.  Multiple packages can be supplied.  
    e.g.: `dinstall install caffe_cudnn tensorflow`  (installs caffe and tensorflow as well as all thier dependencies)
- `uninstall` - removes packages.   Multiple packages can be supplied.
- `upgrade` - upgrades packages.   Multiple packages can be supplied.
- `list` - lists available packages.
- `list installed` - lists installed packages.

Options
- `--help` prints basic usage information.
- `--version` prints version information.
- `--ignore-binaries` installs from source, ignoring available binaries.



### Other commands
- `getCPUNode` gets a node (6 cores, 10GB, 6 hr)
- `getGPUNode` gets a GPU node with a k40 (6 cores, 10GB, 6 hr)
- `getGPULikeNode` gets a node without a GPU, but the same architecture (6 cores, 10GB, 6 hr)



