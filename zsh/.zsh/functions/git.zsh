# Use g as an intelligent git alias
g() {
	if [[ $# -eq 0 ]]; then
		git status --short -b
	elif [[ "$1" == "ppick" ]]; then
		git push || return 1
		git checkout master || return 1
		git cherry-pick local || return 1
		git push || return 1
		git checkout local || return 1
	else
		git $*
	fi
}

