# Wraps mplayer process in order to pause/resume
# using UNIX signals
function mplay() {
  local -a cmd
  cmd=(wrapCmd mplayer -af scaletempo $*)
  if [[ -t 0 ]]; then
    $cmd
  else
    $cmd "$(cat)" </dev/tty
  fi
}

# Stop mplayer using UNIX signals
function mstop() {
  pgrep mplayer | while read pid; do
    kill -STOP $pid
  done
}

# Resume mplayer using UNIX signals
function mcont() {
  pgrep mplayer | while read pid; do
    kill -CONT $pid
  done
}

# Play/pause mplayer
function mtoggle() {
  if ps axo state,pid,command | egrep '^T.*s?mplayer' &>/dev/null; then
    # At least one mplayer process is stopped
    mcont
  else
    mstop
  fi
}

# Play/pause mplayer processes (if any) or MPD
function musicToggle() {
	if pg mplayer &>/dev/null; then
    mtoggle
  else
    mpc toggle
  fi
}

# Play the most recent audio file in the current directory
# (useful for podcast dirs)
function ml() {
	local fn="$(command ls -t | egrep '(mp3|mp4|m4a|m4v|wmv|mkv|avi|ogg|oga|flac|opus)$' | head -n1)"
	echo "Playing $fn"
	mplay $fn
}

