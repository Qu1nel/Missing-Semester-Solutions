#!/usr/bin/env bash
# in debug_script.sh

if [[ "$#" -ne 1 || ! -x "$1" ]]; then
    echo "You must pass the test file as a single argument" 1>&2
    exit 1
fi

result_log_file="log_debugging.log"

count_attempts=1
until [[ "$?" -ne 0 ]]; do
    count_attempts="$((count_attempts + 1))"
    ./"$1" &> "${result_log_file}"
done

echo "Number of successful attempts before failure: ${count_attempts}"
echo "Result output of $1 in ${result_log_file}"
