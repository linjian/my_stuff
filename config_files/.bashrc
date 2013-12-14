# some aliases
alias ll='ls -lFh'
alias la='ls -A'
alias lla='ls -lFHa'
alias l='ls -CF'
alias grep='grep --color=auto'
alias viMode='set -o vi'
alias emacsMode='set -o emacs'
alias ss='ruby script/server'
alias ssp='ruby script/server production'
alias sc='ruby script/console'
alias scproduction='ruby script/console production'
alias mmconsole='~/.gem/ruby/1.8/gems/mongo_mapper-0.8.6/bin/mmconsole'
alias mvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'
alias binstubs='bundle install --binstubs=./bundler_stubs'
# Using sudo with an alias
alias sudo='sudo '
alias rspec-with-gc='DEFER_GC=10 rspec'
alias cucumber-with-gc='DEFER_GC=10 cucumber'
alias nginxStart='sudo /opt/nginx/sbin/nginx'
alias nginxStop='sudo /opt/nginx/sbin/nginx -s stop'
alias nginxReload='sudo /opt/nginx/sbin/nginx -s reload'
# aliases of zeus
alias zc='zeus c'
alias zs='zeus s'
alias zg='zeus g'
alias zrake='zeus rake'
alias zrspec='zeus rspec'

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

# Turn off the terminal driver flow control to disable Ctrl-s and Ctrl-q in terminal for vim
stty -ixon -ixoff

# Command Line Feedback from RVM and Git
export PS1="\[\033[01;34m\]\$(~/.rvm/bin/rvm-prompt) \[\033[01;32m\]\w\[\033[00;33m\]\$(__git_ps1 \" (%s)\") \[\033[01;36m\]\$\[\033[00m\] "

# Add path for mysql on Mac
export PATH=/usr/local/mysql/bin:$PATH

# Fix issue for mysql 5.5 on Mac OS X 10.6
export DYLD_LIBRARY_PATH="/usr/local/mysql/lib:$DYLD_LIBRARY_PATH"

export PATH=/usr/local/lib/node_modules/karma/bin:$PATH
