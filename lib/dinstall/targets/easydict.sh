# returns true if it is installed
is_installed_easydict () {
    python -m pip show easydict &> /dev/null
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_easydict () {
    if [ $HOSTNAME = "user001" ]; then
        echo "Cannot install easydict while on the user node. try getGPULikeNode first!"
        return 1
    fi
    require_packages python27 pip cython
}

uninstall_easydict () {
    python -m pip uninstall -y easydict
}

install_easydict () {
    python -m pip install easydict
}
