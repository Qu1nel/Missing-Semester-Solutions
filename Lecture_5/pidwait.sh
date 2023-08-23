#!/usr/bin/env bash

pidwait ()
{
    if [[ "$#" -ne 1 ]] || ! [[ "$1" =~ '^[0-9]+$' ]]; then
        echo "The pidwait function takes a single numeric argument!" 1>&2
        return 1
    fi

    until [[ "$?" -ne 0 ]]; do
        sleep 1
        kill -0 "$1" 2>/dev/null
    done
}
