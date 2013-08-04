alert() {
  local RET_VAL=$?
  if [[ "$1" == "" ]]; then
    local CMD="$(history|tail -n1|sed -e 's/^\s*[0-9]\+\s*//;s/;\s*alert//')"
  else
    local CMD="$*"
  fi
  notify lib "Finished: [${RET_VAL}] ${CMD}"
}

notify_mpd() {
  mpc toggle &>/dev/null &|
}

notify_sound() {
  local SOUNDDIR=$HOME/.tim
  #local SOUNDFILE=bomb.mp3
  local SOUNDFILE="break.wav"

  if [[ "$1" != "" ]]; then
    SOUNDFILE=$1
  fi

  local RESUMEMPD="$(mpc | grep -i playing)"
  mpc pause &>/dev/null
  mplayer ${SOUNDDIR}/${SOUNDFILE} </dev/null &>/dev/null
  [[ ! -z "${RESUMEMPD}" ]] && mpc play &>/dev/null
}

notify_libnotify() {
  local TEXT='whatever'
  if [[ $# -gt 0 ]]; then
    TEXT="$*"
  fi

  terminal-notifier -message ${TEXT}
}

notify_led() {
  local color=${1-red}
  led on_${color}
}

notify_email() {
  echo $* | mutt -s "Notification from smPc" notify@smattr.de
}

notify() {
  local TYPE=$1

  case $TYPE in
    mpd) notify_mpd ;;
    snd) notify_sound ;;
    lib) shift; notify_libnotify $* ;;
    mail) shift; notify_email $* ;;
    led) shift; notify_led $* ;;
    vis) shift; notify_libnotify $* ;;
    *) notify_sound &
      notify_libnotify $*
      notify_led red ;;
   esac
}

# Notify every 30 seconds
remember() {
  local INTERVAL=30

  if [[ $# -gt 1 ]]; then
    INTERVAL=$1
    shift
  fi

  while true; do
    echo "Alerting in $INTERVAL seconds"
    sleep $INTERVAL
    notify "Alerting $*"
  done
}

# Notifiy after timeout
weckr() {
  typeset -A units
  units=(s 1 m 60 h 1440)

  [[ $# -eq 0 ]] && return 1

  typeset -i secs
  mult="${units[${1[-1]}]}"

  if [[ -z "$mult" ]]; then
    secs="$1"
  else
    secs="${1[1,-2]}"
    ((secs *= mult))
  fi

  local interval=5
  ((times = secs / interval))
  for s in $(seq ${times}); do
    ((p = secs - (s-1)*interval))
    echo -n "${p}.."
    sleep ${interval}
  done

  shift
  notify Wecker klingelt: $*
}

# Notify at specified time
att() {
  local msg="alert"
  [[ -z $1 ]] && echo "Usage: $0 timestring [msg=${msg}]" && return
  local time="$1"
  shift
  msg="${@:-${msg}}"
  echo "zsh -ic \"notify ${msg}\"" | at "${time}"
}

# Notify via email at specified time
atm() {
  local msg="alert"
  [[ -z $1 ]] && echo "Usage: $0 timestring [msg=${msg}]" && return
  local time="$1"
  shift
  msg="${@:-${msg}}"
  ssh vs.smattr.de "echo \"echo ${msg} | mutt -s Notification notify@smattr.de\" | at ${time}"
}

