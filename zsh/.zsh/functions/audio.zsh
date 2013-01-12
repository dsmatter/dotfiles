# Wraps mplayer process in order to pause/resume
# using UNIX signals
mplay() {
  local -a cmd
  cmd=(wrapCmd mplayer -af scaletempo $*)
  if [[ -t 0 ]]; then
    $cmd
  else
    $cmd "$(cat)" </dev/tty
  fi
}

mstop() {
  pgrep mplayer | while read pid; do
    kill -STOP $pid
  done
}

mcont() {
  pgrep mplayer | while read pid; do
    kill -CONT $pid
  done
}

mtoggle() {
  if ps axo state,pid,command | egrep '^T.*s?mplayer' &>/dev/null; then
    # At least one mplayer process is stopped
    mcont
  else
    mstop
  fi
}

# Play/pause mplayer processes (if any) or MPD
musicToggle() {
	if pg mplayer &>/dev/null; then
    mtoggle
  else
    mpc toggle
  fi
}

# Play the most recent audio file in the current directory
# (useful for podcast dirs)
ml() {
	local fn="$(command ls -t | egrep '(mp3|mp4|m4a|m4v|wmv|mkv|avi|ogg|flac|opus)$' | head -n1)"
	echo "Playing $fn"
	mplay $fn
}

