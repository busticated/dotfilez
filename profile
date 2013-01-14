#handle format
export PS1="\u.........\d..\t..........(\w)\n>>"

#aliases
alias cloud9="node /usr/local/share/npm/bin/cloud9 -w /Users/mattmirande/Sites/"
alias redis-server="redis-server /usr/local/etc/redis.conf"
alias cd-bsted="cd /Users/mattmirande/Sites/busticated2.0/"
alias cd-sites="cd /Users/mattmirande/Sites/"
alias cd-dropbox="cd /Users/mattmirande/Dropbox/"
alias cd-chz="cd /Users/mattmirande/Sites/chzbrgr/"
alias edit-profile="start-mvim /Users/mattmirande/.dotfiles/profile"
alias edit-vimrc="start-mvim /Users/mattmirande/.dotfiles/vimrc"
alias edit-hosts="start-mvim /private/etc/hosts sudo"
alias exp="open"

#environment variables
export NODE_ENV="development"
export NODE_PATH="/usr/local/Cellar/node:/usr/local/share/npm/lib/node_modules"
export PATH="/usr/local/share/python":"/usr/local/bin":"/usr/local/sbin":"/usr/local/share/npm/bin":"/usr/local/Cellar/ruby/1.9.3-p194/bin":"/usr/local/Cellar/ruby/1.9.3-p327/bin":$PATH

#helpers
function start-mvim(){
    $2 mvim -c ":lcd %:p:h" $1
}
function throttle-bandwidth(){
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
