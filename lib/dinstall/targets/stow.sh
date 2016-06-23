# returns true if stow is installed
is_installed_stow () {
    test -d $INSTALL_DIR/stow/stow
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_stow () {
    if [ $HOSTNAME = "user001" ]; then
        echo "Cannot install stow while on the user node. try getCPUNode first!"
        return 1
    fi
    return 0
}

uninstall_stow () {
    rm -rf $INSTALL_DIR/stow
}

install_stow () {
    cd $TMPDIR
    mkdir stow; cd stow
    wget http://ftp.gnu.org/gnu/stow/stow-latest.tar.gz
    tar xf stow-latest.tar.gz
    cd stow-*
    ./configure --prefix=$INSTALL_DIR
    if [ $? -ne 0 ]; then
        echo "Error"
        echo "Try running:"
        echo "  cpan App::cpanminus"
        echo "  source ~/.bashrc"
        echo "  cpanm Test::Output"
        cd $TMPDIR
        rm -rf stow
        exit 1

    fi
    make
    make install prefix=$INSTALL_DIR/stow/stow

    cd $INSTALL_DIR/stow
    export PERL5LIB=$INSTALL_DIR/stow/stow/share/perl5:$INSTALL_DIR/stow/stow/share/perl/5.14.2:$PERL5LIB
    stow/bin/stow -vv stow

    cd $TMPDIR
    rm -rf stow
}
