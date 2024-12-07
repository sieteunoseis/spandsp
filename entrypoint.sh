#!/bin/bash

# Check if no arguments are provided
if [ $# -lt 1 ]; then
    echo "No command provided. Starting a default Bash shell..."
    exec /bin/bash
    exit 0
fi

command="/usr/src/spandsp/tests/$1"

# Check if the first argument is ffmpeg, if so, run ffmpeg with the rest of the arguments, else check if the command exists in /usr/src/spandsp/tests
if [ "$1" = "ffmpeg" ]; then
    ffmpeg "${@:2}"
elif [ "$1" = "convert" ]; then
    convert "${@:2}"
elif command -v "$command" > /dev/null 2>&1; then
    $command "${@:2}"
else
    echo "$command is not a valid command in /usr/src/spandsp/tests"
fi