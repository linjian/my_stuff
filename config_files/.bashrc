# some more ls aliases
alias ll='ls -lFh'
alias la='ls -A'
alias lla='ls -lFHa'
alias l='ls -CF'
alias viMode='set -o vi'
alias emacsMode='set -o emacs'
alias ss='ruby script/server'
alias ssp='ruby script/server production'
alias sc='ruby script/console'
alias scproduction='ruby script/console production'
alias mmconsole='~/.gem/ruby/1.8/gems/mongo_mapper-0.8.6/bin/mmconsole'

# This loads RVM into a shell session.
[[ -s "/home/linjian/.rvm/scripts/rvm" ]] && source "/home/linjian/.rvm/scripts/rvm"

# git command auto completion
source ~/.git-completion.bash
