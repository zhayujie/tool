# !/bin/bash

function doCommand() { 
    if [[ ! -f "./host.txt" ]]; then
        echo "No host file!"
        exit 1
    fi

    # while read line || [[ -n $line ]]; do       # can't read the last line
    #cat host.txt | while read line || [[ -n $line ]]; do       # good
    while read line || [[ -n $line ]]; do
        echo "$*"
        ssh ubuntu@$line "$@"
        # ssh ubuntu@$line "$1"                   # not complete correct
        # ssh ubuntu@"$line" "$1"                 # wrong command, don't know why
    done < host.txt
}

if [[ $# -eq 1 ]]; then
    doCommand $1
else
    echo "Wrong arg"
fi