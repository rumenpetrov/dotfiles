# Connect to and initalize gnome-keyring-daemon when in sway session
if [ "$DESKTOP_SESSION" = "sway" ]; then
  export $(gnome-keyring-daemon --start)
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f "$HOME/dotfiles/files/bash/.bash_aliases" ]; then
  . "$HOME/dotfiles/files/bash/.bash_aliases"
fi

#
# Configure the prompt
#
# export PS1='[\u@\h \W]\$'
#
function setPrompt {
  local __user_and_host="\[\033[01;32m\]\u@\h"
  local __cur_location="\[\033[01;34m\][\w]"
  local __git_branch_color="\[\033[31m\]"
  #local __git_branch="\`ruby -e \"print (%x{git branch 2> /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`"
  local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
  local __prompt_tail="\[\033[35m\]$"
  local __last_color="\[\033[00m\]"
  export PS1="\t $__cur_location $__git_branch_color$__git_branch \n$__user_and_host $__prompt_tail$__last_color "
}

setPrompt
