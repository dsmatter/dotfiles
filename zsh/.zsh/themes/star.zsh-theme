nbsp=$'\u00A0'
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✓"

function prompt_char {
	if [ $UID -eq 0 ]; then echo "%{$fg[red]%}#%{$reset_color%}"; else echo "%{$fg[red]%}★%{$reset_color%}"; fi
}

function letter {
  echo -n 'α'
}

PROMPT='%(?, ,%{$fg_bold[red]%}💩 💩 💩  [%?]%{$reset_color%}
)
%{$fg[white]%}⎡ %{$fg_bold[green]%}$(letter) %{$reset_color%}%{$fg[green]%}%~%{$reset_color%}%{$fg[white]%}⎤$(git_prompt_info)
%{$fg[white]%}⎣ %_$(prompt_char)$nbsp$nbsp'

RPROMPT='%{$reset_color%}%{$fg[yellow]%}| %D %*%{$reset_color%}'
