# Include local prompt hostname config
[[ -f $ZSH_HOME/themes/hostname.zsh ]] && source $ZSH_HOME/themes/hostname.zsh

# Set initial prompts
PROMPT='$(~/.zsh/themes/ps1 "$STATUS" "${PROMPT_HOSTNAME:-ƛ}")'
RPROMPT='%{$reset_color%}%{$fg[yellow]%}| %D %*%{$reset_color%}'

# Set up command duration tracking
# See https://github.com/starship/starship/blob/master/src/init/starship.zsh
ps1_precmd() {
    STATUS=$?

    if [[ -n "${PS1_START_TIME+1}" ]]; then
        PS1_END_TIME=$(~/.zsh/themes/ps1 dump_time)
        PS1_DURATION=$((PS1_END_TIME - PS1_START_TIME))
        unset PS1_START_TIME
    else
        unset PS1_DURATION
    fi

    PROMPT='$(~/.zsh/themes/ps1 "$STATUS" "${PROMPT_HOSTNAME:-ƛ}" "${PS1_DURATION-}")'
}

ps1_preexec() {
    PS1_START_TIME=$(~/.zsh/themes/ps1 dump_time)
}

[[ -z "${precmd_functions+1}" ]] && precmd_functions=()
[[ -z "${preexec_functions+1}" ]] && preexec_functions=()

if [[ ${precmd_functions[(ie)ps1_precmd]} -gt ${#precmd_functions} ]]; then
    precmd_functions+=(ps1_precmd)
fi
if [[ ${preexec_functions[(ie)ps1_preexec]} -gt ${#preexec_functions} ]]; then
    preexec_functions+=(ps1_preexec)
fi