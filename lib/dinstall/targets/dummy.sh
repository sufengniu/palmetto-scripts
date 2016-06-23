# returns true (0) if it is installed false (1) if not
is_installed_dummy () {
    return 1
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_dummy () {
    return 0
}

uninstall_dummy () {
    echo "uninstalling dummy!"
}

install_dummy () {
    echo "installing dummy!"
}

