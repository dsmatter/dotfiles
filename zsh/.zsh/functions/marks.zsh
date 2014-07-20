# Simple directory bookmark management
# heavily inspired by http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html

export MARKS_HOME="$HOME/.marks"

function marks_jump {
  builtin cd -P "${MARKS_HOME}/${1}"
}

function marks_add {
  local name="$1"
  local dst="$(pwd)"
  [[ -z $name ]] && name="$(basename $dst)"

  marks_rm "$name"
  ln -s "$dst" "${MARKS_HOME}/${name}"
}

function marks_rm {
  rm -i "${MARKS_HOME}/${1}" 2>/dev/null
}

function marks_ls {
  ls -al "${MARKS_HOME}"
}

# Completions

function _completemarks {
  reply=($(command ls $MARKS_HOME))
}

compctl -K _completemarks marks_jump
compctl -K _completemarks marks_rm

