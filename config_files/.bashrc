# some aliases
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
alias mvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'

# The Vim version Mac OS X 10.6 pre-installed does NOT support Ruby
# Use MacVim in terminal instead
macosVim="/Applications/MacVim.app/Contents/MacOS/Vim"
if [ -f "$macosVim" ]; then
    alias vim="${macosVim}"
fi

# This loads RVM into a shell session.
[[ -s "~/.rvm/scripts/rvm" ]] && source "~/.rvm/scripts/rvm"

# git command auto completion
source ~/.git-completion.bash
