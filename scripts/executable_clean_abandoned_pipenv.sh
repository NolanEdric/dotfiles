#!/usr/bin/env bash

# get all pipenv environments
allPipenvEnv=$(find ~/.local/share/virtualenvs/*/.project -type f)

# find abandoned environments
abandonedEnv=()
for f in $allPipenvEnv; do
    proj_path="$(cat $f)" && [ ! -d $proj_path ] && abandonedEnv+=($proj_path)
done

# if there is any abandoned environment, prompt for cleaning, else, exit
if [ ${#abandonedEnv[@]} -eq 0 ]; then
    echo "No abandoned environment, hooray"
else
    echo "Found ${#abandonedEnv[@]} abandoned pipenv environment(s):"
    for value in "${abandonedEnv[@]}"; do
        echo $value
    done

    echo -e "\nClean up abandoned pipenv environments?"
    select choice in "Yes" "No"; do
        case $choice in
        Yes)
            for f in $allPipenvEnv; do
                proj_path="$(cat $f)" && [ ! -d $proj_path ] && rm -rif ${f//\/.project/} && echo DELETING ${f//\/.project/}
            done
            echo "Done!"
            break
            ;;
        No)
            break
            ;;
        esac
    done
fi
