# returns true if it is installed
is_installed_caffe_rcnn () {
    is_stowed caffe && is_stowed py-faster-rcnn
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_caffe_rcnn () {
    if [ $HOSTNAME = "user001" ]; then
        echo "Cannot install caffe_rcnn while on the user node. try getGPULikeNode first!"
        return 1
    fi
    if is_stowed caffe ; then
        echo "Error: you already have some version of caffe installed. Uninstall it first."
        return 1
    fi
    require_packages gcc cmake python27 numpy scipy opencv leveldb gflags \
        protobuf glog lmdb snappy boost cudnn scikit_image easydict
}

uninstall_caffe_rcnn () {
    unstow caffe
    unstow py-faster-rcnn
}

install_caffe_rcnn () {
   python -m pip install pyyaml
   python -m pip install easydict

   cd $TMPDIR

   git clone --recursive https://github.com/rbgirshick/py-faster-rcnn.git
   cd py-faster-rcnn/lib
   make
   
   mkdir -p $INSTALL_DIR/stow/py-faster-rcnn
   cd ..

   ./data/scripts/fetch_faster_rcnn_models.sh

   cp -r data/ $INSTALL_DIR/stow/py-faster-rcnn/   
   cp -r experiments/ $INSTALL_DIR/stow/py-faster-rcnn/
   cp -r models/ $INSTALL_DIR/stow/py-faster-rcnn/
   cp -r tools/ $INSTALL_DIR/stow/py-faster-rcnn/
   cp -r lib $INSTALL_DIR/stow/py-faster-rcnn/

   cd caffe-fast-rcnn/
   # allow the use of boost 1.60: see https://github.com/BVLC/caffe/pull/3575
   git remote add upstream https://github.com/BVLC/caffe.git
   git fetch upstream
   git cherry-pick de31e034e5570056666d161ce10078011b0f1601
   mkdir build
   cd build
   cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/stow/caffe \
       -DCMAKE_PREFIX_PATH=$INSTALL_DIR -DBOOST_ROOT=$INSTALL_DIR \
       -DBLAS=MKL -DINTEL_ROOT=/software/intel/composer_xe_2015 \
       -DPYTHON_LIBRARY=$INSTALL_DIR/lib/libpython2.7.so \
       -DPYTHON_INCLUDE_DIR=$INSTALL_DIR/include/python2.7 \
       -DPROTOBUF_INCLUDE_DIR=$INSTALL_DIR/include \
       -DPROTOBUF_LIBRARY=$INSTALL_DIR/lib/libprotobuf.so \
       -DPROTOBUF_PROTOC_LIBRARY=$INSTALL_DIR/lib/libprotoc.so \
       -DCUDNN_ROOT=$INSTALL_DIR ..
   make -j$cores
   make install

   cd ..
   mkdir $INSTALL_DIR/stow/caffe/caffe
   cp -r data/ $INSTALL_DIR/stow/caffe/caffe
   cp -r models/ $INSTALL_DIR/stow/caffe/caffe
   cp -r examples/ $INSTALL_DIR/stow/caffe/caffe
   cp -r tools/ $INSTALL_DIR/stow/caffe/caffe
   cp -r scripts/ $INSTALL_DIR/stow/caffe/caffe
   cd build

   dostow caffe
   dostow py-faster-rcnn

   

   cd $TMPDIR
   rm -rf py-faster-rcnn
}

binary_deploy_caffe_rcnn () {
    cd $INSTALL_DIR/stow
    tar -czvf $binary_path/caffe_rcnn.tar.gz caffe py-faster-rcnn
}
binary_install_caffe_rcnn () {
    cd $INSTALL_DIR/stow
    tar -xvf $binary_path/caffe_rcnn.tar.gz
    dostow caffe
    dostow py-faster-rcnn
}
binary_available_caffe_rcnn () {
    test -f $binary_path/caffe_rcnn.tar.gz
}

