# Use g as an intelligent git alias
function g() {
  if [[ $# -eq 0 ]]; then
    git status --short -b
  elif [[ "$1" == "ppick" ]]; then
    git stash || return 1
    git push || return 1
    git checkout master || return 1
    git cherry-pick local || return 1
    git push || return 1
    git checkout local || return 1
    git stash pop || return 1
  elif [[ "$1" == "apply" ]]; then
    git checkout master || return 1
    git pull || return 1
    git rebase master local || return 1
  else
    git $*
  fi
}

compdef g=git
