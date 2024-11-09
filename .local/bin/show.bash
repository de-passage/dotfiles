#!/usr/bin/env bash
# vim: ft=bash

file="${@}"

echo "$(tput rev)${file}$(tput sgr0)"
if [[ -f "${file}" ]]; then
  bat --color always --decorations never "${file}"
elif [[ -d "${file}" ]]; then
  ls -lhA --color=always "${file}"
else
  file "${file}"
fi
