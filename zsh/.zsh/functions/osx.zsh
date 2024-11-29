function robotsay() {
  say -v Zarvox $*
}

function rmDownloadHistory() {
  sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'
}

function um() {
  sudo diskutil umount $*
}

# Changes the working directory to the current location of the top-most Finder window
function cdf() {
  cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')"
}

