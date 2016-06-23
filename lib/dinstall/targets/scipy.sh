# returns true if it is installed
is_installed_scipy () {
    python -m pip show scipy &> /dev/null
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_scipy () {
    if [ $HOSTNAME = "user001" ]; then
        echo "Cannot install scipy while on the user node. try getGPULikeNode first!"
        return 1
    fi
    require_packages python27 pip numpy
}

uninstall_scipy () {
    python -m pip uninstall -y scipy
}

install_scipy () {
    python -m pip install scipy
}
