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
    'gitconfig'
    'gitignore_global'
    'ackrc'
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
exit
