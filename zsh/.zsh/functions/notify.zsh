function alert() {
  local RET_VAL=$?
  if [[ "$1" == "" ]]; then
    local CMD="$(history|tail -n1|sed -e 's/^\s*[0-9]\+\s*//;s/;\s*alert//')"
  else
    local CMD="$*"
  fi
  notify lib "Finished: [${RET_VAL}] ${CMD}"
}

notify_libnotify() {
  local TEXT='whatever'
  if [[ $# -gt 0 ]]; then
    TEXT="$*"
  fi

  terminal-notifier -message ${TEXT}
}

function notify() {
  local TYPE=$1

  case $TYPE in
    lib) shift; notify_libnotify $* ;;
    *) notify_libnotify $* ;;
   esac
}

# Notify every 30 seconds
function remember() {
  local INTERVAL=30

  if [[ $# -gt 0 ]]; then
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
function weckr() {
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
function att() {
  local msg="alert"
  [[ -z $1 ]] && echo "Usage: $0 timestring [msg=${msg}]" && return
  local time="$1"
  shift
  msg="${@:-${msg}}"
  echo "zsh -ic \"notify ${msg}\"" | at "${time}"
}

