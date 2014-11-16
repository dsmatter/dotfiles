# Set zsh home
export ZSH_HOME="${HOME}/.zsh"

# Use custom completion path
fpath=($fpath "$ZSH_HOME/completions")

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

typeset -U path

# Source global profile
source /etc/profile

# Set options
setopt autocd 
setopt beep 
setopt extendedglob 
setopt nomatch 
setopt no_hup 
setopt cdablevars 
setopt autopushd 
setopt prompt_subst
setopt inc_append_history

# Autoload functions
autoload -Uz compinit
autoload -U edit-command-line
autoload colors zsh/terminfo

# Initialize completion engine
compinit

# Initialize fasd
if hash fasd &>/dev/null; then
  eval "$(fasd --init auto)"
fi

# Include user scripts
for f in $ZSH_HOME/*.zsh; do
  source $f;
done

# Always a good read ;)
if hash fortune; then
	echo
	echo -------------------------------------------------------------------------------- 
	echo
	fortune -s
	echo
	echo -------------------------------------------------------------------------------- 
	echo
fi

return 0
