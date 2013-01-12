dumpasx() {
  mplayer -dumpstream -playlist $*
}

dumpharaldschmidt() {
  rtmpdump -o "video1.f4v" --host vod.daserste.de --port 1935 --protocol rtmp --playpath  mp4:$* --swfUrl http://dms.dmc.at/ardplayer/swf/ardplayer3.swf --tcUrl rtmp://vod.daserste.de/ardfs --pageUrl http://www.ardmediathek.de/ard/servlet/content/2600 --app ardfs --flashVer LNX 10,2,153,1
}

dumpzdf() {
  rtmpdump -o "video1.f4v" --host 84.53.146.135 --port 1935 --protocol rtmp --playpath $* --swfUrl http://www.zdf.de/ZDFmediathek/flash/data/swf/AkamaiBa.sicStreamingPlugin.swf --tcUrl rtmp://cp125301.edgefcs.net:1935/ondemand --pageUrl http://www.zdf.de/ZDFmediathek/beitrag/video/1334528/heute-show-vom-13.0.5.2011 --app ondemand --flashVer LNX 10,2,159,1
}

dumpsat1() {
  rtmpdump -o "video1.f4v" --host 198.78.208.126 --port 1935 --protocol rtmp --playpath $* --swfUrl http://www.sat1.de/imperia/moveplayer/.HybridPlayer.swf --tcUrl rtmp://pssimsat1fs.fplive.net:1935/pssimsat1ls/geo_d_at_ch --pageUrl http://www.sat1.de/comedy_show/wochenshow/video/ganze-folgen/.clip_wochenshow-vom-27-05-2011_185348/ --app pssimsat1ls/geo_d_at_ch --flashVer LNX 10,2,159,1
}

dumparte() {
  rtmpdump -o "video1.f4v" --host 87.248.197.225 --port 1935 --protocol rtmp --playpath $* --swfVfy http://videos.arte.tv/blob/web/i18n/view/player_18-3188338-data-4921491.swf --tcUrl rtmp://artestras.fcod.llnwd.net/a3903/o35 --pageUrl http://videos.arte.tv/de/videos/vom_digitalangriff_zum_cyberkrieg_-3945070.html --app a3903/o35 --flashVer LNX 10,2,159,1
}

getVideoLink() {
  sudo tcpflow -c | egrep --color 'mp4|flv|f4v|asx|rtmp'
}

dumpFlash() {
  local FPID=$(ps ax | grep npviewer | grep -v grep | awk '{ print $1 }' | head -n1)
  find /proc/${FPID}/fd -lname "*deleted*" | while read l; do
    ls -al $l
  done
}

screencast() {
  local fn="/tmp/out.mpg"
  if [[ "$1" != "" ]]; then
    fn="$1"
  fi
  echo Streaming to $fn
  ffmpeg -f x11grab -s wxga -r 25 -i :0.0 -sameq $fn
}
