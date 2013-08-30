function dumpasx() {
  mplayer -dumpstream -playlist $*
}

function getVideoLink() {
  sudo tcpflow -c | egrep --color 'mp4|flv|f4v|asx|rtmp'
}

function dumpFlash() {
  local FPID=$(ps ax | grep npviewer | grep -v grep | awk '{ print $1 }' | head -n1)
  find /proc/${FPID}/fd -lname "*deleted*" | while read l; do
    ls -al $l
  done
}

function screencast() {
  local fn="/tmp/out.mpg"
  if [[ "$1" != "" ]]; then
    fn="$1"
  fi
  echo Streaming to $fn
  ffmpeg -f x11grab -s wxga -r 25 -i :0.0 -sameq $fn
}
