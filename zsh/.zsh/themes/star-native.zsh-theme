[[ -f $ZSH_HOME/themes/hostname.zsh ]] && source $ZSH_HOME/themes/hostname.zsh

export PROMPT='$(~/.zsh/themes/ps1 $? $UID "${PROMPT_HOSTNAME:-ƛ}")'
export RPROMPT='%{$reset_color%}%{$fg[yellow]%}| %D %*%{$reset_color%}'
