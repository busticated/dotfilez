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
if [ ! -d "$HOME/.vim/backup" ]; then
    echo ":::: Creating required VIM directories..."
    mkdir -p ~/.vim/backup
    mkdir -p ~/.vim/bundle
    mkdir -p ~/.vim/tmp
else
    echo ":::: VIM directories already available. Skipping..."
fi

# dirs mongodb requires
sudo mkdir -p ~/mongodata/db

# grab vundle if needed
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
    echo ":::: Installing vim vundle plugin manager..."
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
    echo ":::: vim vundle already installed. Skipping..."
fi

# install brew and brewfile bundles
if [[ $(command -v brew) == "" ]]; then
    echo ":::: Installing homebrew package manager..."
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
