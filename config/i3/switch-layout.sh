#!/bin/bash

LAYOUT=$(setxkbmap -query | grep layout | tr -s ' ' | cut -d ' ' -f2)

if [[ $LAYOUT == 'us' ]]; then
  setxkbmap -layout se
elif [[ $LAYOUT == 'se' ]]; then
  setxkbmap -layout us
fi

