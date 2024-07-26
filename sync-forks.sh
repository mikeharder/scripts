#!/bin/bash

# Get the directory of the script
SCRIPT_DIR=$(dirname "$(realpath "$0")")

while IFS= read -r repo; do
  gh repo sync mikeharder/$repo &
done < "$SCRIPT_DIR/sync-forks.txt"
