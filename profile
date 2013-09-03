#handle format
export PS1="\u.........\d..\t..........(\w)\n>>"

#aliases
alias cd-bsted="cd /Users/mattmirande/Sites/busticated2.0/"
alias cd-sites="cd /Users/mattmirande/Sites/"
alias cd-dropbox="cd /Users/mattmirande/Dropbox/"
alias cd-mombo="cd /Users/mattmirande/Sites/mombo-labs/"
alias edit-profile="startMvim /Users/mattmirande/.dotfiles/profile"
alias edit-vimrc="startMvim /Users/mattmirande/.dotfiles/vimrc"
alias edit-hosts="startMvim /private/etc/hosts sudo"
alias exp="open"
alias exp-iosapps="exp ~/Library/Application\ Support/iPhone\ Simulator/"
alias kill-node="ps -Ax | grep '[n]ode'| cut -f 1 -d ' '| xargs kill"

#environment variables
export NODE_ENV="development"
export NODE_PATH="/usr/local/Cellar/node:/usr/local/share/npm/lib/node_modules"
export PATH="bin":"node_modules/.bin":"/usr/local/bin":"/usr/local/sbin":"/usr/local/share/npm/bin":"/usr/local/Cellar/ruby/1.9.3-p362/bin":$PATH

#helpers
function startMvim(){
    $2 mvim -c ":lcd %:p:h" $1
}

function throttleBandwidth(){
    add=${1:-true}
    speed=${2:-500}
    port=${3:-80}

    if [ $add == true ]
    then
        sudo ipfw pipe 1 config bw $speed"KByte/s"
        sudo ipfw add 1 pipe 1 src-port $port
        echo "speed:" $speed"KByte/s"
        echo "port: " $port
    else
        sudo ipfw delete 1
        echo "filter removed from port: " $port
    fi
}

# bash completion helper (see: http://bash-completion.alioth.debian.org/ )
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# {{{
# Node Completion - Auto-generated, do not touch.
shopt -s progcomp
for f in $(command ls ~/.node-completion); do
  f="$HOME/.node-completion/$f"
  test -f "$f" && . "$f"
done
# }}}
