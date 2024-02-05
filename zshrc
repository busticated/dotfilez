# prompt
NEWLINE=$'\n'
export PS1="%n.........%D{%a %b %f %r}..........(%~)${NEWLINE}>>"

# aliases
alias edit-profile="startMvim ${HOME}/.dotfiles/profile"
alias edit-zshrc="startMvim ${HOME}/.dotfiles/zshrc"
alias edit-vimrc="startMvim ${HOME}/.dotfiles/vimrc"
alias edit-hosts="startMvim /private/etc/hosts sudo"
alias exp="open"
alias exp-iossim="exp ~/Library/Application\ Support/iPhone\ Simulator/"
alias kill-node="ps -Ax | grep '[n]ode'| cut -f 1 -d ' '| xargs kill"
alias npm-exec='PATH=$(npm bin):$PATH'

# environment variables
# export JAVA_HOME=$(/usr/libexec/java_home)
export NODE_ENV="development"
export PATH=$PATH:"/usr/local/sbin":"/usr/local/share/android-sdk/platform-tools":"$HOME/.cargo/bin":"$(brew --prefix ruby)/bin"

# history
setopt SHARE_HISTORY # share history across sessions
setopt APPEND_HISTORY # append to history
setopt INC_APPEND_HISTORY # adds commands as they are typed, not upon exit
setopt HIST_EXPIRE_DUPS_FIRST # expire duplicates first
setopt HIST_IGNORE_DUPS # do not store duplications
setopt HIST_FIND_NO_DUPS # ignore duplicates when searching
setopt HIST_REDUCE_BLANKS # removes blank lines from history
setopt EXTENDED_HISTORY # store meta-data (timestamp, elapsed) along with command
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE
export HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history

# node.js
eval "$(fnm env --use-on-cd)" # switch node version based on .nvmrc - see: https://github.com/Schniz/fnm
fnm default 20

# completions
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit
autoload bashcompinit && bashcompinit
source <(npm completion)

# gpg
export GPG_TTY=$(tty)

# prtcl
eval $(prtcl autocomplete:script zsh)

### PARTICLE BIN --- START
export PATH="$HOME/.particle/bin":$PATH
### PARTICLE BIN --- END

# particle (legacy)
## added by Particle CLI
# add home bin directory to PATH if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi


# helpers
function startMvim(){
    $2 mvim -c ":lcd %:p:h" $1
}

