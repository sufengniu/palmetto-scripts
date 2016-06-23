# returns true if it is installed
is_installed_ipdb () {
    python -m pip show ipdb &> /dev/null
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_ipdb () {
    if [ $HOSTNAME = "user001" ]; then
        echo "Cannot install ipdb while on the user node. try getGPULikeNode first!"
        return 1
    fi
    require_packages python27 pip
}

uninstall_ipdb () {
    python -m pip uninstall -y ipdb
}

install_ipdb () {
    python -m pip install ipdb
}
