# returns true if it is installed
is_installed_numpy () {
    python -m pip show numpy &> /dev/null
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_numpy () {
    if [ $HOSTNAME = "user001" ]; then
        echo "Cannot install numpy while on the user node. try getGPULikeNode first!"
        return 1
    fi
    require_packages python27 pip cython
}

uninstall_numpy () {
    python -m pip uninstall -y numpy
}

install_numpy () {
    python -m pip install numpy
}
