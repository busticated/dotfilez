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

# user config files
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

# dirs vim requires
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/tmp

# grab vundle if needed
if [ ! -d "$HOME/.vim/bundle/vundle" ]; then
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi

# setup symlinks for user config files
linkUserConfigFiles ${files[@]}

# setup symlinks to misc configs
ln -siv $DOTFILESDIR/apache/httpd.conf /Applications/MAMP/conf/apache/httpd.conf
exit
