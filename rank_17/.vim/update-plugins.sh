#!/bin/bash

# -print0 use the null character to separated each directory in the output, and -d '' means that readarray expect the null character as delimiter
readarray -d '' plugins < <(find ./pack -mindepth 3 -maxdepth 3 -type d -not -path '*.git*' -print0)

for plugin in "${plugins[@]}"; do
    echo "Updating $plugin"

    if [ -d "$plugin/.git" ]
    then
        cd "$plugin" || exit
        echo "Status for $plugin"
        git status
        echo "Fetching $plugin"
        git fetch
        echo "Pulling $plugin"
        git pull
        cd - || exit
    else
        echo "Skipping $plugin - it's not a Git repository"
    fi
done
