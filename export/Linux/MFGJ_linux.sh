#!/bin/sh
echo -ne '\033c\033]0;MFGJ\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/MFGJ_linux.x86_64" "$@"
