#! /bin/bash
set -e
user=$(whoami)

# Setup symlinks for various config files
ln -s gvimrc $HOME/.gvimrc
ln -s vimrc $HOME/.vimrc
ln -s profile $HOME/.profile
ln -s NERDTreeBookmarks $HOME/.NERDTreeBookmarks
ln -s hgrc $HOME/.hgrc
ln -s gitignore_global $HOME/.gitignore_global
ln -s gitconfig $HOME/.gitconfig
ln -s conf/apache/httpd.conf /Applications/MAMP/conf/apache/httpd.conf
