#! /bin/bash
set -e
USER=$(whoami)
DOTFILESDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

linkUserConfigFiles(){
    for filename in $@
    do
       ln -siv $DOTFILESDIR/$filename $HOME/.$filename
    done
}

# Setup symlinks for user config files
files=(
    'profile'
    'gvimrc'
    'vimrc'
    'hgrc'
    'gitconfig'
    'gitignore_global'
    'jshintrc'
    'NERDTreeBookmarks'
)
# TODO: Make Dirs ~/.vim/backup, ~/.vim/bundle, ~/.vim/tmp
# TODO: git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
linkUserConfigFiles ${files[@]}

# setup symlinks to misc configs
ln -siv $DOTFILESDIR/apache/httpd.conf /Applications/MAMP/conf/apache/httpd.conf
exit
