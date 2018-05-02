#!/bin/bash
# kill fricking ubersicht with its damn name

_kill() {
    sic=( $( ps aux|grep -i sicht|grep Applications|awk '{print $2}' ) )
    for pid in $sic; do printf "killing pid: $pid ...\n"; kill -9 $pid; done
}

_open() {
    printf "Starting app (takes a few seconds) ...\n"

    sleep 2
    open -a /Applications/Übersicht.app
}

if [[ -n "$1" ]] && [[ "$1" == "-k" ]]
then
    _kill
else
    _kill
    _open
fi
