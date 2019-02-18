#!/bin/sh
main() {
    for i in {0..1000}; do
        ./scoreboard-manipulator
    done
}

echo "Building release"
dub build -b release > /dev/null

echo "Generating 1000 scoreboards"
time main
