# Use g as an intelligent git alias
function g() {
  if [[ $# -eq 0 ]]; then
    git status --short -b
  else
    git $*
  fi
}

compdef g=git
