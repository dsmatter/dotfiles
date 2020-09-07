_zoxide_precmd() {
    zoxide add
}

[[ -n "${precmd_functions[(r)_zoxide_precmd]}" ]] || {
    precmd_functions+=(_zoxide_precmd)
}

z() {
    if [ "$#" -eq 0 ]; then
        cd "$HOME"
    elif [ "$#" -eq 1 ] && [ "$1" = "-" ]; then
        cd "-"
    else
        _Z_RESULT=$(zoxide query "$@")
        case "$_Z_RESULT" in
            "query: "*)
                cd "${_Z_RESULT:7}"
                ;;
            *)
                echo -n "$_Z_RESULT"
                ;;
        esac
    fi
}


alias zi="z -i"

alias za="zoxide add"
alias zq="zoxide query"
alias zr="zoxide remove"

