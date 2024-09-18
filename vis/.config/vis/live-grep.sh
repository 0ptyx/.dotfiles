#!/usr/bin/env bash


if [ -z "$1" ]; then
	echo ''
else
	rg -n --color=always --smart-case $1
fi
