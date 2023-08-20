#!/usr/bin/env bash
# in marco.sh

marco ()
{
    MarcoPoloPath="$(pwd)"
}

polo ()
{
    [[ -n "$MarcoPoloPath" ]] && cd "$MarcoPoloPath" || return 1
}
