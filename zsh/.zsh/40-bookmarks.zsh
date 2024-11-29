#!/bin/zsh

hash -d code="$HOME/code"
hash -d ln="$HOME/code/ln"
hash -d tum="$HOME/Documents/TUM"
hash -d zc="$HOME/.zsh"

# Semesters
for i in `seq 1 12`; do
  hash -d sem${i}="$DOC_HOME/TUM/Semester ${i}"
done

