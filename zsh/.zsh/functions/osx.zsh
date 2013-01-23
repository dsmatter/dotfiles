fixOpenWith() {
  # From: http://osxdaily.com/2013/01/22/fix-open-with-menu-mac-os-x/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+osxdaily+%28OS+X+Daily%29
  /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain user
  killall Finder
  echo "Open With has been rebuilt, Finder will relaunch"
}
