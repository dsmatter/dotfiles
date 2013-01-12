#!/bin/zsh

hash -d knapp="$DEVEL_HOME/ruby/rails/knappdaneben"
hash -d fancy="$DOC_HOME/TUM/Semester 6/dbmca/workspace/myFancyDB"
hash -d ba="$DOC_HOME/TUM/Semester 6/ba"
hash -d lg="$HOME/dev/git/licensegarden"
hash -d tum="$DOC_HOME/TUM"
hash -d zc="$DEVEL_HOME/zsh"
hash -d baa="$DEVEL_HOME/git/tum/ba/android"
hash -d proxy="/home/smatter/dev/git/tum/ba/android/workspace/Proxy"
hash -d vwis="/home/smatter/dev/git/tum/vwis"
hash -d vm="$DOC_HOME/TUM/Semester 8/vm"
hash -d qo="$DOC_HOME/TUM/Semester 8/qo"
hash -d da="$DOC_HOME/TUM/Semester 8/da"
hash -d pp="$DOC_HOME/TUM/Semester 8/pp"
hash -d cb="$DOC_HOME/TUM/Semester 8/cb"
hash -d cg="$DOC_HOME/TUM/Semester 8/cg"

# Semesters
for i in `seq 1 9`; do
  hash -d sem${i}="$DOC_HOME/TUM/Semester ${i}"
done

