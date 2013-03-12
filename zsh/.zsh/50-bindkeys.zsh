#!/bin/zsh 

bindkey -v
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\ee[C" forward-word
bindkey "\ee[D" backward-word
bindkey "^H" backward-delete-word
# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
#cursor at the end of the line in history
bindkey "\e[A" up-line-or-history
bindkey "\e[B" down-line-or-history
# for non RH/Debian xterm, can't hurt for RH/DEbian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix

# Alt + Arrows
bindkey '[1;3A' history-beginning-search-backward
bindkey '[1;3B' history-beginning-search-forward

#PageUp/Down
bindkey '[5~' history-beginning-search-backward
bindkey '[6~' history-beginning-search-forward

# Esc + Return enters new line
bindkey '^[^M' self-insert-unmeta

# Ctrl + X
bindkey -M viins '^X' push-line-or-edit

# Completion debugging
bindkey '' _complete_help

# Pasting the prompt makes it disappear
# That's a non-breaking space
nbsp=$'\u00A0'
bindkey -s $nbsp '^u'

# fooling around
#bindkey -s 'ss ' 'sudo '

