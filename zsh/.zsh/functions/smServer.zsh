function sssh() {
  if ping -c1 smserver &>/dev/null; then
    mosh smserver $*
  else
    mosh -p 2222 smatter@smattr.de $*
  fi;
}

function smlp() {
  fn="$1"
  shift
  cat $fn | sssh /usr/bin/lp $*
}

function mountSmServer() {
	if ! mount | grep -i /Volumes/smserver; then
    if ping -c1 smserver &>/dev/null; then
      sshfs smserver:/ /Volumes/smserver
    else
      sshfs -p 2222 smatter@smattr.de:/ /Volumes/smserver
    fi
	fi
}

function umountSmServer() {
	local -a mpoints
	mpoints=(/Volumes/smserver)

	for mpoint in $mpoints; do
		if mount | grep -i $mpoint; then
			echo "Trying umount"
			umount $mpoint && continue
			echo "Trying diskutil"
			sudo diskutil umount $mpoint && continue
			echo "Trying diskutil w/ force"
			sudo diskutil umount force $mpoint && continue

			echo "Failed to umount $mpoint"
		fi
	done
}

function remountSmServer() {
  umountSmServer
  mountSmServer
}

# Show and prompt the most recent podcast files on the server
function pods() {
  local remote_podcast_dir=/heaven/podcasts
	local local_podcast_dir=/media/smserver${remote_podcast_dir}
  local days=14

	# Test user passed $days as an argument
  if [[ ! -z "$1" ]]; then
    days="$1"
  fi

	# Mount the server
  mountSmServer &>/dev/null
  sleep 1

  local -a file_array
  local c=1

	# Find the episodes within the $days boundary
  ssh smserver "find $remote_podcast_dir -type f \
    '(' -iname '*.mp3' -or -iname '*.m4a' -or -iname '*.ogg' -or -iname '*.oga' ')' \
    -mtime -${days} -print0 | xargs -0 ls -at" | while read line
	do
    file_array=($file_array $line)
    echo "[${c}] $(basename "$(dirname ${line})")/$(basename ${line})"
    (( c = c + 1 ))
  done

	# Show the episode list, prompt and play
  local no
  echo -n "Play no > "
  read no
  local toplay="${file_array[${no}]}"
  mplay -novideo ${toplay/$remote_podcast_dir/$local_podcast_dir}
}

# Open file in remote VLC
function smVlc() {
	# URL encode the argument
	local url="$(ruby -e "require \"open-uri\"; puts URI::encode(\"${1}\")")"
	# Ask the remote VLC to play the file
	curl "http://smserver:8080/requests/status.xml?command=in_play&input=${url}"
}

# Wake smServer
function wolSmServer() {
  wol "c8:60:00:6d:cf:e9"
  curl -L "http://pi.smatterling.de/api/wol/smServer?token=$PISERVER_TOKEN"
}

function smerte() {
  sssh "bin/smerte $*"
}

function bt() {
  sssh "zsh -ic 'bt $*'"
}

