#handle format
export PS1="\u.........\d..\t..........(\w)\n>>"

#aliases
alias cloud9="node /usr/local/share/npm/bin/cloud9 -w /Users/mattmirande/Sites/"
alias redis-server="redis-server /usr/local/etc/redis.conf"
alias cd-bsted="cd /Users/mattmirande/Sites/busticated2.0/"
alias cd-sites="cd /Users/mattmirande/Sites/"
alias cd-dropbox="cd /Users/mattmirande/Dropbox/"
alias cd-chz="cd /Users/mattmirande/Sites/chzbrgr/"
alias cd-chzUT="cd /Users/mattmirande/Sites/chzbrgr/icanhaz/wp-content/themes/Unified/"
alias edit-profile="start-mvim /Users/mattmirande/.dotfiles/profile"
alias edit-vimrc="start-mvim /Users/mattmirande/.dotfiles/vimrc"
alias edit-hosts="start-mvim /private/etc/hosts sudo"
alias exp="open"

#environment variables
export NODE_PATH="/usr/local/lib/node"
export PATH="/usr/local/bin":"/usr/local/sbin":"/usr/local/Cellar/ruby/1.9.3-p0/bin":"/usr/local/Cellar/ruby/1.9.2-p290/bin":$PATH

#helpers
function start-mvim(){
    $2 mvim -c ":lcd %:p:h" $1
}
