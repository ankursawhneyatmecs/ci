#!/bin/bash
filename="${1##*/}"
if [[ "${filename%.*}" =~ [^a-z0-9_] ]]; then
   echo "$filename"
fi
