# returns true if it is installed
is_installed_scikit_image () {
    python -c "import skimage" &> /dev/null
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_scikit_image () {
    if [ $HOSTNAME = "user001" ]; then
        echo "Cannot install scikit_image while on the user node. try getGPULikeNode first!"
        return 1
    fi
    require_packages python27 pip
}

uninstall_scikit_image () {
    python -m pip uninstall -y scikit-image
}

install_scikit_image () {
    python -m pip install scikit-image
}
