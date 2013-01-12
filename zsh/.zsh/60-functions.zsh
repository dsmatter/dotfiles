#!/bin/zsh

for f in $(dirname $0)/functions/*.zsh; do
  source $f
done

