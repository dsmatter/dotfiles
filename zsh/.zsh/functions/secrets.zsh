function bankdata() {

  cd $HOME/.tmp
  local BANKDIR="$HOME/Documents/Bank"
  local TMPDIR=`mktemp -d bankdata`
  local BANKFN="bank.tar.gz.gpg"

  cp $BANKDIR/$BANKFN $TMPDIR
  if ! gpg -d $TMPDIR/${BANKFN} | tar xzv -C ${TMPDIR}; then
      echo "Wrong password!"
      rm -rf ${TMPDIR}
      return 1
  fi
  open ${TMPDIR}

  for x in `seq 30 -1 1`; do
      if expr ${x} % 15 = 0 &>/dev/null || [ ${x} -lt 16 ]; then
	  echo "Deleting tmp-dir in ${x} seconds"
      fi
      sleep 1
  done
  
  rm -rf ${TMPDIR}
}

passman_() {
  # passman - GPL3 - nibble <develsec.org> 2009
  # Minimal password manager

  PASSFILE=~/Dropbox/passman
  TMPFILE=~/.passmandb.$$

  trap "rm -f ${TMPFILE}" 0 2 15 &&
  umask 177 &&
	if [[ "$1" != "" ]]; then
		gpg -d ${PASSFILE} | egrep -i "$1"
		exit 0
	fi
  if [[ -e ${PASSFILE} ]]; then
    gpg --no-use-agent -o ${TMPFILE} -d ${PASSFILE}
  else
    touch ${TMPFILE}
  fi &&
  vim "+set viminfo=" "+set noswapfile" ${TMPFILE} + &&
  gpg --no-use-agent -r "high" -a -o ${PASSFILE} -e ${TMPFILE} 
}

function passman() {
	zsh -ic "passman_ $*"
}

function gpgAll() {
  find . -type f ! -name "*.gpg" -exec gpg -r high -e {} ';'
  echo -n "done. Wanna delete unencrypted files? [y/N] > "
  if read -q; then
    find . -type f ! -name "*.gpg" -delete
  fi
}

function gpgDecAll() {
  gpg --decrypt-files **/*.gpg
}

function showPwDialog() {
	osascript -e 'Tell application "System Events" to display dialog "Password:" default answer "" with hidden answer' -e 'text returned of result'
}

function genpasswd() {
	local l=$1
	[[ "$l" == "" ]] && l=16
	tr -dc 'A-Za-z0-9_' < /dev/urandom | head -c ${l} | xargs
}

