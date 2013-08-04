#!/bin/zsh

hash -d tum="$DOC_HOME/TUM"
hash -d zc="$HOME/.zsh"

# Semesters
for i in `seq 1 12`; do
  hash -d sem${i}="$DOC_HOME/TUM/Semester ${i}"
done

