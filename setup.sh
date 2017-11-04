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
    echo ":::: Installing vim vundle plugin manager..."
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
else
    echo ":::: vim vundle already installed. Skipping..."
fi

# install brew and brewfile bundles
if [[ $(command -v brew) == "" ]]; then
    echo "Installing homebrew package manager..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap homebrew/bundle
    brew bundle
else
    echo ":::: Updating homebrew packages..."
    brew update
fi

# setup symlinks for user config files
echo ":::: Linking config files..."
linkUserConfigFiles ${files[@]}
exit
