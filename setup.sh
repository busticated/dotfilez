#! /bin/bash
set -eu
USER=$(whoami)
DOTFILESDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

linkUserConfigFiles(){
    for filename in $@
    do
       ln -siv $DOTFILESDIR/$filename $HOME/.$filename
    done
}

touchWithConfirmation(){
    for spec in $@; do
        IFS=';' read -a tuple <<< "$spec"
        label="${tuple[0]}"
        file="${HOME}/${tuple[1]}"

        if [ ! -d $file ]; then
            echo ":::: Creating file: ${file} for ${label}"
            touch $file
        else
            echo ":::: File exists, skipping: ${file} for ${label}"
        fi
    done
}

mkdirWithConfirmation(){
    for spec in $@; do
        IFS=';' read -a tuple <<< "$spec"
        label="${tuple[0]}"
        dir="${HOME}/${tuple[1]}"

        if [ ! -d $dir ]; then
            echo ":::: Creating directory: ${dir} for ${label}"
            mkdir -p $dir
        else
            echo ":::: Directory exists, skipping: ${dir} for ${label}"
        fi
    done
}

# user config files
configfiles=(
    'profile'
    'zshrc'
    'gvimrc'
    'vimrc'
    'gitconfig'
    'gitignore_global'
    'ackrc'
    'NERDTreeBookmarks'
)

# required files
files=(
    "BASH;.bash_history"
    "BASH;.bash_session_disable" # see: https://stackoverflow.com/a/46248280
)

# required directories
directories=(
    "GIT;code/bust"
    "GIT;code/chz"
    "GIT;code/mombo"
    "GIT;code/particle"
    "VIM;.vim/backup"
    "VIM;.vim/bundle"
    "VIM;.vim/tmp"
    "HOMEBREW;Library/Caches/Homebrew"
    "MONGODB;.mongo/db"
    "ZSH;.zsh/completion"
)

# check if we're ready to install - - - - - - - - - - - - - - - - - - - - - - -
echo ":::: Running preflight check..."

if id -Gn $USER | grep -q -w admin; then
    echo ":::: Your user (${USER}) has correct permissions";
else
    echo ":::: Your user (${USER}) must be an admin";
    exit 1
fi

case $DOTFILESDIR in
    *.dotfiles)
        echo ":::: Dotfilez repo location is correct"
        ;;
    *)
        echo ":::: Dotfilez repo was cloned into the wrong directory - please use: ${HOME}/.dotfiles"
        exit 1
        ;;
esac

# create required files - - - - - - - - - - - - - - - - - - - - - - - - - - - -
echo ":::: Creating required files..."
touchWithConfirmation ${files[@]}

# create required directories - - - - - - - - - - - - - - - - - - - - - - - - -
echo ":::: Creating required directories..."
mkdirWithConfirmation ${directories[@]}

# grab vim-plug if needed
vimplugpath="$HOME/.vim/autoload/plug.vim"

if [ ! -d $vimplugpath ]; then
    echo ":::: Installing VIM plugin manager..."
    curl -fLo $vimplugpath --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
else
    echo ":::: VIM plugin manager already installed. Skipping..."
fi

# install brew and brewfile bundles - - - - - - - - - - - - - - - - - - - - - -
if [[ $(command -v brew) == "" ]]; then
    echo ":::: Installing Homebrew package manager..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew tap homebrew/bundle
    brew bundle
else
    echo ":::: Updating Homebrew packages..."
    brew update
fi

# setup symlinks for user config files - - - - - - - - - - - - - - - - - - - -
echo ":::: Linking config files..."
linkUserConfigFiles ${configfiles[@]}

# setup node - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
echo ":::: Configuring Node.js environment..."
brew unlink node && brew link node@12 --force --overwrite
npm completion > /usr/local/etc/bash_completion.d/npm
exit

