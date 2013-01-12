parse_git_dirty () {
	if [[ -n $(git status -s -uno 2> /dev/null) ]]
	then
		echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
	else
		echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
	fi
}
