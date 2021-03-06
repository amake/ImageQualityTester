#!/usr/bin/env bash
set -eu

export MAGICK_HOME="$(pwd)/ImageMagick"
export PATH="${MAGICK_HOME}/bin:$PATH"
export DYLD_LIBRARY_PATH="${MAGICK_HOME}/lib/"

function processOne() {
    file="$1"
    base="${file%.*}"

    for q in $(seq 100 -10 10) 95 85; do
        convert "$file" -quality $q "${base}_q${q}.jpg"
    done
}

for arg in "$@"; do
    processOne "$arg"
done
