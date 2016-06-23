# returns true if it is installed
is_installed_caffe_cudnn () {
    is_stowed caffe
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_caffe_cudnn () {
    if [ $HOSTNAME = "user001" ]; then
        echo "Cannot install caffe_cudnn while on the user node. try getGPULikeNode first!"
        return 1
    fi
    require_packages gcc cmake python27 numpy scipy opencv leveldb gflags \
        protobuf glog lmdb snappy boost cudnn scikit_image
}

uninstall_caffe_cudnn () {
    unstow caffe
}

install_caffe_cudnn () {
    cd $TMPDIR

    git clone https://github.com/BVLC/caffe.git
    mkdir caffe/build
    cd caffe/build
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

    cd $TMPDIR
    rm -rf caffe
}

binary_deploy_caffe_cudnn () {
    cd $INSTALL_DIR/stow
    tar -czvf $binary_path/caffe_cudnn.tar.gz caffe
}
binary_install_caffe_cudnn () {
    cd $INSTALL_DIR/stow
    tar -xvf $binary_path/caffe_cudnn.tar.gz
    dostow caffe
}
binary_available_caffe_cudnn () {
    test -f $binary_path/caffe_cudnn.tar.gz
}

