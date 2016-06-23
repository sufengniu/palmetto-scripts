# returns true if it is installed
is_installed_cudnn () {
    is_stowed cudnn
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_cudnn () {
    if [ $HOSTNAME = "user001" ]; then
        echo "Cannot install cudnn while on the user node. try getGPULikeNode first!"
        return 1
    fi
    require_packages gcc boost
}

uninstall_cudnn () {
    unstow cudnn
}

install_cudnn () {
    cd $TMPDIR
    mkdir $INSTALL_DIR/stow/cudnn
    cp /home/wbgreen/cudnn-7.0-linux-x64-v4.0-prod.tgz .
    tar -xzvf cudnn-7.0-linux-x64-v4.0-prod.tgz
    
    cd cuda
    cp -r * $INSTALL_DIR/stow/cudnn

    dostow cudnn

    cd $TMPDIR
    rm -rf cudnn
}

